-module(solution).
-export([search_insert/2]).

search_insert(Nums, Target) ->
    search_insert_split(Nums, Target, 0).

search_insert_split(Nums, Target, Offset) ->
    Len = length(Nums),
    case Len of
        0 ->
            Offset;
        _ ->
            MidIdx = Len div 2,
            {Left, [MidElem | Right]} = lists:split(MidIdx, Nums),
            if
                MidElem == Target ->
                    Offset + MidIdx;
                MidElem < Target ->
                    search_insert_split(Right, Target, Offset + MidIdx + 1);
                true -> %% MidElem > Target
                    search_insert_split(Left, Target, Offset)
            end
    end.