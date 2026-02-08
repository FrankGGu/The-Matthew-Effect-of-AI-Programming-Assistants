-module(solution).
-export([longestNiceSubstring/1]).

is_lower(C) when C >= $a, C =< $z -> true;
is_lower(_) -> false.

is_upper(C) when C >= $A, C =< $Z -> true;
is_upper(_) -> false.

to_lower(C) when C >= $A, C =< $Z -> C + ($a - $A);
to_lower(C) -> C.

to_upper(C) when C >= $a, C =< $z -> C - ($a - $A);
to_upper(C) -> C.

is_nice_string_internal(S, CharSet) ->
    case S of
        [] -> true;
        [C|Rest] ->
            Target = if is_lower(C) -> to_upper(C);
                       is_upper(C) -> to_lower(C);
                       true -> C
                    end,
            if Target =:= C ->
                is_nice_string_internal(Rest, CharSet);
               sets:is_element(Target, CharSet) ->
                is_nice_string_internal(Rest, CharSet);
               true ->
                false
            end
    end.

is_nice_string(S) ->
    CharSet = sets:from_list(S),
    is_nice_string_internal(S, CharSet).

find_problematic_char_loop(S, CurrentIdx, CharSet) ->
    case S of
        [] ->
            {nil, nil};
        [C | Rest] ->
            Target = if is_lower(C) -> to_upper(C);
                       is_upper(C) -> to_lower(C);
                       true -> C
                    end,
            if Target =:= C ->
                find_problematic_char_loop(Rest, CurrentIdx + 1, CharSet);
               not sets:is_element(Target, CharSet) ->
                {CurrentIdx, C};
               true ->
                find_problematic_char_loop(Rest, CurrentIdx + 1, CharSet)
            end
    end.

compare_results(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    if Len1 >= Len2 -> S1;
       true -> S2
    end.

longestNiceSubstring(S) ->
    if is_nice_string(S) ->
        S;
    true ->
        CharSet = sets:from_list(S),
        {ProblematicCharIdx, _} = find_problematic_char_loop(S, 0, CharSet),

        LeftPart = lists:sublist(S, ProblematicCharIdx),
        RightPart = lists:nthtail(ProblematicCharIdx + 1, S),

        ResLeft = longestNiceSubstring(LeftPart),
        ResRight = longestNiceSubstring(RightPart),

        compare_results(ResLeft, ResRight)
    end.