-module(largest_time_from_digits).
-export([largest_time/1]).

largest_time(Digits) ->
    lists:sort(Digits, fun(A, B) -> A > B end),
    Permutations = get_permutations(Digits),
    valid_times(Permutations).

get_permutations(List) ->
    get_permutations_helper(List, []).

get_permutations_helper([], Acc) ->
    [lists:reverse(Acc)];
get_permutations_helper(List, Acc) ->
    lists:flatmap(fun(X) ->
                          get_permutations_helper(lists:delete(X, List), [X | Acc])
                  end, List).

valid_times(Permutations) ->
    valid_times_helper(Permutations, []).

valid_times_helper([], Acc) ->
    case Acc of
        [] -> "";
        _ ->
            Sorted = lists:sort(Acc, fun(A, B) -> A > B end),
            [H1, H2, M1, M2] = hd(Sorted),
            io_lib:format("~p~p:~p~p", [H1, H2, M1, M2])
    end.

valid_times_helper([Permutation | Rest], Acc) ->
    [H1, H2, M1, M2] = Permutation,
    case is_valid_time(H1, H2, M1, M2) of
        true ->
            valid_times_helper(Rest, [Permutation | Acc]);
        false ->
            valid_times_helper(Rest, Acc)
    end.

is_valid_time(H1, H2, M1, M2) ->
    Hour = H1 * 10 + H2,
    Minute = M1 * 10 + M2,
    Hour >= 0 andalso Hour < 24 andalso Minute >= 0 andalso Minute < 60.