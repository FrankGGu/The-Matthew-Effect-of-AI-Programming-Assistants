-module(substring_matching_pattern).
-export([match/2]).

match(Pattern, S) ->
    match(Pattern, S, 0, 0, []).

match([], [], _, _, _) ->
    true;
match([], _, _, _, _) ->
    false;
match(_, [], _, _, _) ->
    false;
match([H|T], [C|S], I, J, Map) ->
    case maps:find(H, Map) of
        {ok, C} ->
            match(T, S, I+1, J+1, Map);
        error ->
            case lists:keymember(C, 1, maps:to_list(Map)) of
                true ->
                    false;
                false ->
                    NewMap = maps:put(H, C, Map),
                    match(T, S, I+1, J+1, NewMap)
            end
    end.