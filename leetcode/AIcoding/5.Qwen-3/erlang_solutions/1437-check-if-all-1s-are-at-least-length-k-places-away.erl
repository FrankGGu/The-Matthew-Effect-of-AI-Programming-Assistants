-module(solution).
-export([k_length_apart/2]).

k_length_apart(B, K) ->
    k_length_apart(B, K, -1).

k_length_apart([], _, _) ->
    true;
k_length_apart([0 | T], K, Last) ->
    k_length_apart(T, K, Last);
k_length_apart([1 | T], K, Last) ->
    if
        Last == -1 -> k_length_apart(T, K, 0);
        true -> 
            if
                (Last + K) < 0 -> k_length_apart(T, K, 0);
                (Last + K) >= 0 -> k_length_apart(T, K, 0)
            end
    end.