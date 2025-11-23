-module(solution).
-export([largestTimeFromDigits/1]).

largestTimeFromDigits(A) ->
    Permutations = lists:permute(A),
    ValidTimes = lists:filtermap(
        fun(P) ->
            [D1, D2, D3, D4] = P,
            H = D1 * 10 + D2,
            M = D3 * 10 + D4,
            if
                H >= 0 andalso H =< 23 andalso M >= 0 andalso M =< 59 ->
                    {true, io_lib:format("~2.0B:~2.0B", [H, M])};
                true ->
                    false
            end
        end,
        Permutations
    ),
    case ValidTimes of
        [] ->
            "";
        _ ->
            lists:flatten(lists:last(lists:sort(ValidTimes)))
    end.