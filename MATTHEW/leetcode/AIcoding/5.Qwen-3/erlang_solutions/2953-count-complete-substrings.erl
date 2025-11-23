-module(solution).
-export([count_complete_substrings/1]).

count_complete_substrings(S) ->
    count_complete_substrings(S, 0, 0, 0, []).

count_complete_substrings([], _, _, _, Acc) ->
    lists:sum(Acc);
count_complete_substrings([H | T], Start, Length, Count, Acc) ->
    case is_valid(H) of
        true ->
            case Length == 0 of
                true ->
                    count_complete_substrings(T, Start, 1, 1, Acc);
                false ->
                    count_complete_substrings(T, Start, Length + 1, Count + 1, Acc)
            end;
        false ->
            case Length > 0 of
                true ->
                    NewAcc = [Count | Acc],
                    count_complete_substrings(T, Start, 0, 0, NewAcc);
                false ->
                    count_complete_substrings(T, Start, 0, 0, Acc)
            end
    end.

is_valid(C) ->
    C >= $a andalso C =< $z.