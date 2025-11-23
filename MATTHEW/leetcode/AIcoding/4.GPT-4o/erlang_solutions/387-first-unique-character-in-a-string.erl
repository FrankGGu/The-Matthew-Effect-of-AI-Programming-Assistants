-module(solution).
-compile([export_all]).

-spec first_uniq_char(S :: unicode:unicode_binary()) -> integer().
first_uniq_char(S) ->
    first_uniq_char(S, []).

first_uniq_char([], _) -> -1;
first_uniq_char([H | T], Seen) when lists:member(H, Seen) -> 
    first_uniq_char(T, Seen);
first_uniq_char([H | T], Seen) ->
    case lists:member(H, T) of
        true -> first_uniq_char(T, [H | Seen]);
        false -> length(Seen)
    end.
