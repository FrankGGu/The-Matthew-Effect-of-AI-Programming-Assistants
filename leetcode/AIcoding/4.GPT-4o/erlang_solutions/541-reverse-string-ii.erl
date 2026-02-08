-module(solution).
-export([reverse_str/2]).

reverse_str(S, K) ->
    reverse_parts(S, K, 0).

reverse_parts([], _, _) -> [];
reverse_parts(Str, K, Pos) ->
    {Prefix, Rest} = lists:split(K, Str),
    {ToReverse, Remaining} = lists:split(K, Rest),
    Reversed = lists:reverse(ToReverse),
    Reversed ++ reverse_parts(Remaining, K, Pos + K).