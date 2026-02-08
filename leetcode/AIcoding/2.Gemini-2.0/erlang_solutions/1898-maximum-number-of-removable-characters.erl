-module(maximum_removable_characters).
-export([maximumRemovals/3]).

maximumRemovals(S, P, Removable) ->
    maximumRemovals(S, P, Removable, 0, length(Removable) - 1).

maximumRemovals(S, P, Removable, Low, High) ->
    case Low > High of
        true ->
            Low;
        false ->
            Mid = (Low + High + 1) div 2,
            case isSubsequence(S, P, Removable, Mid) of
                true ->
                    maximumRemovals(S, P, Removable, Mid, High);
                false ->
                    maximumRemovals(S, P, Removable, Low, Mid - 1)
            end
    end.

isSubsequence(S, P, Removable, K) ->
    Removed = lists:sublist(Removable, K),
    SList = string:to_list(S),
    PList = string:to_list(P),
    isSubsequenceHelper(SList, PList, Removed, []).

isSubsequenceHelper(_, [], _, _) ->
    true;
isSubsequenceHelper([], _, _, _) ->
    false;
isSubsequenceHelper(SList, PList, Removed, Acc) ->
    [H | T] = PList,
    Result = findNext(SList, H, Removed, Acc),
    case Result of
        none ->
            false;
        {ok, Index} ->
            isSubsequenceHelper(T, string:to_list(S), Removed, [Index | Acc])
    end.

findNext([], _, _, _) ->
    none;
findNext(SList, Char, Removed, Acc) ->
    findNextHelper(SList, Char, Removed, Acc, 0).

findNextHelper([], _, _, _, _) ->
    none;
findNextHelper(SList, Char, Removed, Acc, Index) ->
    [H | T] = SList,
    case H =:= Char of
        true ->
            case lists:member(Index, Removed) of
                true ->
                    findNextHelper(T, Char, Removed, Acc, Index + 1);
                false ->
                    case lists:any(fun(I) -> I < Index end, Acc) of
                        true ->
                            findNextHelper(T, Char, Removed, Acc, Index + 1);
                        false ->
                            {ok, Index}
                    end
            end;
        false ->
            findNextHelper(T, Char, Removed, Acc, Index + 1)
    end.