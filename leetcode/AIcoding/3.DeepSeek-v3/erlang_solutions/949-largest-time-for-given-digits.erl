-module(solution).
-export([largest_time_from_digits/1]).

largest_time_from_digits(A) ->
    Perms = permutations(A),
    ValidTimes = lists:filter(fun is_valid_time/1, Perms),
    case ValidTimes of
        [] -> "";
        _ ->
            [H|M] = lists:max(ValidTimes),
            format_time(H, M)
    end.

permutations([]) -> [[]];
permutations(L) -> [[H|T] || H <- L, T <- permutations(L -- [H])].

is_valid_time([H1, H2, M1, M2]) ->
    Hours = H1 * 10 + H2,
    Minutes = M1 * 10 + M2,
    Hours < 24 andalso Minutes < 60.

format_time([H1, H2, M1, M2], _) ->
    Hours = integer_to_list(H1 * 10 + H2),
    Minutes = integer_to_list(M1 * 10 + M2),
    string:join([pad_zero(Hours), pad_zero(Minutes)], ":").

pad_zero(Str) when length(Str) == 1 -> "0" ++ Str;
pad_zero(Str) -> Str.