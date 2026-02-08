-module(solution).
-export([smallest_string/1]).

find_start_idx(List, AccIdx) ->
    case List of
        [] -> -1;
        [H | T] ->
            if H > $a ->
                    AccIdx;
               true ->
                    find_start_idx(T, AccIdx + 1)
            end
    end.

find_end_idx_from_sublist(SubList, CurrentOffset) ->
    case SubList of
        [] -> CurrentOffset;
        [H | T] ->
            if H == $a ->
                    CurrentOffset;
               true ->
                    find_end_idx_from_sublist(T, CurrentOffset + 1)
            end
    end.

-spec smallest_string(S :: unicode:unicode_list()) -> unicode:unicode_list().
smallest_string(S) ->
    Chars = S, 

    StartIdx = find_start_idx(Chars, 0),

    case StartIdx of
        -1 ->
            Chars;
        _ ->
            {Prefix, Rest} = lists:split(StartIdx, Chars),

            RelativeEndIdx = find_end_idx_from_sublist(Rest, 0),

            {ToOperate, Suffix} = lists:split(RelativeEndIdx, Rest),

            Operated = [C - 1 || C <- ToOperate],

            Prefix ++ Operated ++ Suffix
    end.