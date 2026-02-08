-module(solution).
-export([distinct_echo_substrings/1]).

distinct_echo_substrings(S) ->
    N = length(S),
    Substrings = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            Sub = lists:sublist(S, I, J),
            case lists:prefix(S, Sub) of
                true -> lists:append(Acc2, [Sub]);
                false -> Acc2
            end
        end, Acc, lists:seq(1, N - I))
    end, [], lists:seq(1, N)),
    lists:usort(Substrings).