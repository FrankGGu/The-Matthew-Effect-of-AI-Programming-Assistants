-module(solution).
-export([get_length/1]).

get_length(Magic) ->
    N = length(Magic),
    if 
        N == 0 -> 0;
        true ->
            {MaxLen, _} = lists:foldl(
                fun(Char, {Max, Map}) ->
                    case maps:get(Char, Map, undefined) of
                        undefined -> 
                            NewMap = maps:put(Char, 1, Map),
                            {max(Max, maps:size(NewMap)), NewMap};
                        Count -> 
                            NewMap = maps:put(Char, Count + 1, Map),
                            {Max, NewMap}
                    end
                end,
                {0, #{}},
                Magic
            ),
            MaxLen
    end.