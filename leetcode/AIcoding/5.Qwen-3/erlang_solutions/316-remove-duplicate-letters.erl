-module(remove_duplicate_letters).
-export([remove_duplicates/1]).

remove_duplicates(S) ->
    remove_duplicates(S, [], 0, []).

remove_duplicates([], Stack, _, Result) ->
    lists:reverse(Result);
remove_duplicates([C | T], Stack, Pos, Result) ->
    case lists:member(C, Stack) of
        true ->
            case lists:member(C, Result) of
                false ->
                    Index = lists:foldl(fun({X, I}, Acc) -> if X == C -> I; true -> Acc end end, -1, lists:zip(Stack, lists:seq(0, length(Stack)-1))),
                    if Index == -1 -> remove_duplicates(T, Stack, Pos+1, Result);
                       true ->
                            NewStack = lists:sublist(Stack, Index) ++ lists:sublist(Stack, Index+1, length(Stack) - Index -1),
                            remove_duplicates(T, NewStack, Pos+1, [C | Result])
                    end;
                false ->
                    remove_duplicates(T, Stack, Pos+1, Result)
            end;
        false ->
            remove_duplicates(T, [C | Stack], Pos+1, Result)
    end.