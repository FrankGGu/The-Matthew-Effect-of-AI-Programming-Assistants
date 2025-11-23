-module(largest_time_for_given_digits).
-export([largestTimeFromDigits/1]).

largestTimeFromDigits(Digits) ->
    Perms = permutations(Digits),
    ValidTimes = [T || T <- Perms, is_valid_time(T)],
    case ValidTimes of
        [] -> "";
        _ -> lists:foldl(fun(T, Acc) -> compare_times(T, Acc) end, hd(ValidTimes), tl(ValidTimes))
    end.

permutations([]) -> [[]];
permutations(L) ->
    [[H | T] || H <- L, T <- permutations(lists:delete(H, L))].

is_valid_time([H1, H2, M1, M2]) ->
    Hour = H1 * 10 + H2,
    Min = M1 * 10 + M2,
    Hour < 24 andalso Min < 60.

compare_times([H1, H2, M1, M2], [H1a, H2a, M1a, M2a]) ->
    Hour = H1 * 10 + H2,
    Houra = H1a * 10 + H2a,
    if
        Hour > Houra -> [H1, H2, M1, M2];
        true -> [H1a, H2a, M1a, M2a]
    end.