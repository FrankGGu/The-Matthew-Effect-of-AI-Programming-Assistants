-module(maximum_odd_binary_number).
-export([solve/1]).

solve(BinStr) ->
    Count = lists:foldl(fun($1, Acc) -> Acc + 1; (_, Acc) -> Acc end, 0, BinStr),
    case Count of
        0 -> "0";
        _ -> lists:flatten([lists:duplicate(Count - 1, $1), "0", lists:duplicate(length(BinStr) - Count, $0)])
    end.