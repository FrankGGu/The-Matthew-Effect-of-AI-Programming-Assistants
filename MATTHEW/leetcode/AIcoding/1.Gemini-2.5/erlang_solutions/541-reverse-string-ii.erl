-module(solution).
-export([reverse_str/2]).

reverse_str(S, K) ->
    reverse_str_impl(S, K).

reverse_str_impl([], _K) ->
    [];
reverse_str_impl(S, K) ->
    Len = length(S),
    if
        Len < K ->
            lists:reverse(S);
        Len >= K andalso Len < 2*K ->
            {FirstK, Rest} = lists:split(K, S),
            lists:reverse(FirstK) ++ Rest;
        true -> % Len >= 2*K
            {FirstK, Temp} = lists:split(K, S),
            {NextK, Remaining} = lists:split(K, Temp),
            lists:reverse(FirstK) ++ NextK ++ reverse_str_impl(Remaining, K)
    end.