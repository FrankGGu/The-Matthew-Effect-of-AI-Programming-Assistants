-module(solution).
-export([total_characters_in_string_after_transformations_ii/3]).

get_kth_char(StartChar, K, TransformMap) ->
    Path = [],
    Visited = maps:new(),
    get_kth_char_loop(StartChar, K, TransformMap, 0, Path, Visited).

get_kth_char_loop(CurrentChar, K, TransformMap, Step, Path, Visited) ->
    case maps:is_key(CurrentChar, Visited) of
        true ->
            CycleStartStep = maps:get(CurrentChar, Visited),
            CycleLength = Step - CycleStartStep,

            ReversedPath = lists:reverse(Path),

            FinalIndexInPath = 
                if K < CycleStartStep ->
                    K;
                else
                    (K - CycleStartStep) rem CycleLength + CycleStartStep
                end,

            lists:nth(FinalIndexInPath + 1, ReversedPath);
        false ->
            NextChar = maps:get(CurrentChar, TransformMap, CurrentChar),
            get_kth_char_loop(NextChar, K, TransformMap, Step + 1, [CurrentChar | Path], maps:put(CurrentChar, Step, Visited))
    end.

total_characters_in_string_after_transformations_ii(S, Transformations, K) ->
    TransformMap = lists:foldl(
        fun(TStr, Acc) -> 
            maps:put(hd(TStr), hd(tl(TStr)), Acc) 
        end, 
        maps:new(), 
        Transformations
    ),

    FinalTransformationsArray = lists:foldl(
        fun(CharVal, AccArray) ->
            StartChar = $a + CharVal,
            FinalChar = get_kth_char(StartChar, K, TransformMap),
            array:set(CharVal, FinalChar, AccArray)
        end, 
        array:new(26), 
        lists:seq(0, 25)
    ),

    TotalSum = lists:foldl(
        fun(Char, AccSum) ->
            CharVal = Char - $a,
            TransformedChar = array:get(CharVal, FinalTransformationsArray),
            AccSum + (TransformedChar - $a + 1)
        end, 
        0, 
        S
    ),

    TotalSum.