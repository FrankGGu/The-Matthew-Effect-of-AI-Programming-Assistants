-module(solution).
-export([num_decodings/1]).

num_decodings(S) ->
    N = length(S),
    DP = array:new(N + 1, {default, 0}),
    DP1 = array:set(N, 1, DP),
    {Ans, _} = helper(S, 0, DP1),
    Ans.

helper(S, I, DP) ->
    case array:get(I, DP) of
        0 ->
            case string:substr(S, I + 1, 1) of
                "0" ->
                    {0, DP};
                _ ->
                    {Res1, DP1} = helper(S, I + 1, DP),
                    case string:substr(S, I + 1, 2) of
                        [A, B] when A =:= $1 orelse (A =:= $2 andalso B =< $6) ->
                            {Res2, DP2} = helper(S, I + 2, DP1),
                            {Res1 + Res2, array:set(I, Res1 + Res2, DP2)};
                        _ when I + 1 < length(S) ->
                            {Res1, array:set(I, Res1, DP1)};
                        _ ->
                            {Res1, array:set(I, Res1, DP1)}
                    end
            end;
        Val ->
            {Val, DP}
    end.