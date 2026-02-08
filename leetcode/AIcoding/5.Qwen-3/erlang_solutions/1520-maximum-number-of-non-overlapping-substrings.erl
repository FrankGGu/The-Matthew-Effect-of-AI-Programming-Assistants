-module(solution).
-export([max_num_non_overlapping/1]).

max_num_non_overlapping(S) ->
    max_num_non_overlapping(S, 0, [], []).

max_num_non_overlapping([], _, _, Acc) ->
    length(Acc);
max_num_non_overlapping(S, Start, Seen, Acc) ->
    case find_min_length(S, Start, Seen) of
        false ->
            max_num_non_overlapping(S, Start + 1, Seen, Acc);
        {L, R} ->
            max_num_non_overlapping(S, R + 1, [L | Seen], [R | Acc])
    end.

find_min_length(S, Start, Seen) ->
    find_min_length(S, Start, Seen, infinity, -1).

find_min_length(_, _, _, MinLen, MinPos) when MinLen /= infinity ->
    {MinPos, MinPos + MinLen - 1};
find_min_length(S, Start, Seen, MinLen, MinPos) ->
    case Start >= erlang:length(S) of
        true ->
            false;
        false ->
            L = Start,
            R = find_end(S, Start, []),
            case R of
                false ->
                    find_min_length(S, Start + 1, Seen, MinLen, MinPos);
                _ ->
                    Len = R - L + 1,
                    case is_valid(S, L, R, Seen) of
                        true ->
                            if
                                Len < MinLen ->
                                    find_min_length(S, Start + 1, Seen, Len, L);
                                true ->
                                    find_min_length(S, Start + 1, Seen, MinLen, MinPos)
                            end;
                        false ->
                            find_min_length(S, Start + 1, Seen, MinLen, MinPos)
                    end
            end
    end.

find_end(_, _, _) -> false;
find_end(S, Pos, Acc) ->
    case Pos >= erlang:length(S) of
        true ->
            false;
        false ->
            Char = lists:nth(Pos + 1, S),
            case lists:member(Char, Acc) of
                true ->
                    Pos;
                false ->
                    find_end(S, Pos + 1, [Char | Acc])
            end
    end.

is_valid(_, _, _, []) ->
    true;
is_valid(S, L, R, [H | T]) ->
    case H < L orelse H > R of
        true ->
            is_valid(S, L, R, T);
        false ->
            false
    end.