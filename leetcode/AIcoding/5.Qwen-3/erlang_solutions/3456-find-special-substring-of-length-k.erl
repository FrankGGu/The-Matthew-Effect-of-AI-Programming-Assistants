-module(solution).
-export([find_special_substring/1]).

find_special_substring(S) ->
    N = erlang:length(S),
    K = 3,
    find_special_substring(S, N, K, 0, 0).

find_special_substring(_, _, _, _, Max) when Max > 0 -> Max;
find_special_substring(S, N, K, I, Max) when I + K > N -> Max;
find_special_substring(S, N, K, I, Max) ->
    Sub = erlang:substring(S, I + 1, K),
    case is_special(Sub) of
        true -> find_special_substring(S, N, K, I + 1, I + 1);
        false -> find_special_substring(S, N, K, I + 1, Max)
    end.

is_special([A, B, C]) ->
    A == B orelse B == C orelse A == C;
is_special(_) ->
    false.