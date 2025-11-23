-module(solution).
-export([makeLargestSpecial/1]).

makeLargestSpecial(S) ->
    makeLargestSpecial_impl(S, 0, 0, 0, []).

makeLargestSpecial_impl(S, Idx, Count, StartIdx, Acc) when Idx < length(S) ->
    Char = lists:nth(Idx + 1, S),
    NewCount = case Char of
        $1 -> Count + 1;
        $0 -> Count - 1
    end,
    case NewCount of
        0 ->
            InnerString = lists:sublist(S, StartIdx + 2, Idx - StartIdx - 1),
            RecursiveResult = makeLargestSpecial(InnerString),
            CurrentSpecial = [$1 | RecursiveResult ++ [$0]],
            makeLargestSpecial_impl(S, Idx + 1, 0, Idx + 1, [CurrentSpecial | Acc]);
        _ ->
            makeLargestSpecial_impl(S, Idx + 1, NewCount, StartIdx, Acc)
    end;
makeLargestSpecial_impl(_S, _Idx, _Count, _StartIdx, Acc) ->
    SortedAcc = lists:sort(fun(A, B) -> A >= B end, Acc),
    lists:flatten(SortedAcc).