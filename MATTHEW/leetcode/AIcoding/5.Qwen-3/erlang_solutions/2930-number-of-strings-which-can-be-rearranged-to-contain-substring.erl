-module(solution).
-export([num_strings/1]).

num_strings(Params) ->
    [S, K, Sub] = Params,
    Len = length(S),
    Count = 0,
    num_strings(S, K, Sub, Len, Count).

num_strings(_, _, _, 0, Acc) ->
    Acc;
num_strings(S, K, Sub, N, Acc) ->
    Start = len(Sub),
    if
        N < Start -> Acc;
        true ->
            SubStr = lists:sublist(S, N - Start + 1, Start),
            case lists:member(SubStr, lists:seq(1, K)) of
                true -> num_strings(S, K, Sub, N - 1, Acc + 1);
                false -> num_strings(S, K, Sub, N - 1, Acc)
            end
    end.