-module(solution).
-export([num_substrings/1]).

num_substrings(BinaryString) ->
    Count = lists:foldl(fun(Char, {C, Total}) ->
        case Char of
            $\$1 -> {C + 1, Total + C + 1};
            _ -> {0, Total}
        end
    end, {0, 0}, list_to_binary(BinaryString)),
    element(2, Count).