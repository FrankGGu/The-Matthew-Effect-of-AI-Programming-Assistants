-module(scramble_string).
-export([is_scramble/2]).

is_scramble(S1, S2) ->
    case length(S1) =/= length(S2) of
        true -> false;
        false -> is_scramble_helper(S1, S2)
    end.

is_scramble_helper(S1, S2) ->
    case S1 =:= S2 of
        true -> true;
        false ->
            case is_anagram(S1, S2) of
                false -> false;
                true ->
                    N = length(S1),
                    lists:any(fun(I) ->
                        S11 = string:substr(S1, 1, I),
                        S12 = string:substr(S1, I + 1),
                        S21 = string:substr(S2, 1, I),
                        S22 = string:substr(S2, I + 1),
                        (is_scramble_helper(S11, S21) andalso is_scramble_helper(S12, S22)) orelse
                        (S21 = string:substr(S2, N - I + 1),
                        S22 = string:substr(S2, 1, N - I),
                        (is_scramble_helper(S11, S21) andalso is_scramble_helper(S12, S22))
                    end, lists:seq(1, N - 1))
            end
    end.

is_anagram(S1, S2) ->
    lists:sort(S1) =:= lists:sort(S2).