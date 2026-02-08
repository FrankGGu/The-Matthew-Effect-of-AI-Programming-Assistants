-module(solution).
-export([num_monkeys/1]).

num_monkeys(Num) ->
    case Num of
        0 -> 0;
        _ -> (math:pow(2, Num) - 2) rem 1000000007
    end.