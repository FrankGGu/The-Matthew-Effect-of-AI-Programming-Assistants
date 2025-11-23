-module(solution).
-export([equalDistinctCharacters/2]).

build_freq_map(Word) ->
    lists:foldl(
        fun(Char, AccMap) ->
            maps:update_with(Char, fun(V) -> V + 1 end, 1, AccMap)
        end,
        maps:new(),
        Word
    ).

simulate_swap(Map1_in, Map2_in, Char1, Char2) ->
    Map1_after_Char1_removal =
        case maps:get(Char1, Map1_in) of
            1 -> maps:remove(Char1, Map1_in);
            Count -> maps:put(Char1, Count - 1, Map1_in)
        end,
    Map1_final = maps:update_with(Char2, fun(V) -> V + 1 end, 1, Map1_after_Char1_removal),

    Map2_after_Char2_removal =
        case maps:get(Char2, Map2_in) of
            1 -> maps:remove(Char2, Map2_in);
            Count -> maps:put(Char2, Count - 1, Map2_in)
        end,
    Map2_final = maps:update_with(Char1, fun(V) -> V + 1 end, 1, Map2_after_Char2_removal),

    {Map1_final, Map2_final}.

equalDistinctCharacters(Word1, Word2) ->
    InitialMap1 = build_freq_map(Word1),
    InitialMap2 = build_freq_map(Word2),

    Chars = lists:seq($a, $z),

    lists:any(
        fun(Char1) ->
            case maps:is_key(Char1, InitialMap1) of
                true ->
                    lists:any(
                        fun(Char2) ->
                            case maps:is_key(Char2, InitialMap2) of
                                true ->
                                    {NewMap1, NewMap2} = simulate_swap(InitialMap1, InitialMap2, Char1, Char2),
                                    map_size(NewMap1) == map_size(NewMap2);
                                false ->
                                    false
                            end
                        end,
                        Chars
                    );
                false ->
                    false
            end
        end,
        Chars
    ).