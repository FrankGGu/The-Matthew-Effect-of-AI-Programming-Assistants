-module(longest_substring).
-export([longest_abc/1]).

longest_abc(S) ->
    Max = 0,
    Vowels = "aeiou",
    Map = maps:from_list([{C, I} || {I, C} <- lists:zip(lists:seq(0, 4), Vowels)]),
    longest_abc(S, 0, 0, Max, Map).

longest_abc([], _, _, Max, _) -> Max;
longest_abc([C | T], Pos, Current, Max, Map) ->
    case maps:is_key(C, Map) of
        true ->
            case Pos of
                0 ->
                    longest_abc(T, 1, 1, Max, Map);
                _ ->
                    Prev = maps:get(C, Map),
                    if
                        Prev < Pos - 1 ->
                            longest_abc(T, Pos + 1, 1, Max, Map);
                        true ->
                            longest_abc(T, Pos + 1, Current + 1, max(Max, Current + 1), Map)
                    end
            end;
        false ->
            longest_abc(T, 0, 0, Max, Map)
    end.