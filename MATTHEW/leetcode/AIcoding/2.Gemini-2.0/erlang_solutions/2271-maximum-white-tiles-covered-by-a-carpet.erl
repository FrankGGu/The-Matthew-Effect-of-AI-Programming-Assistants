-module(maximum_white_tiles).
-export([maximum_white_tiles/2]).

maximum_white_tiles(Tiles, CarpetLen) ->
    SortedTiles = lists:sort(Tiles),
    maximum_white_tiles_helper(SortedTiles, CarpetLen, 0, 0, 0).

maximum_white_tiles_helper([], _CarpetLen, _Index, _Current, Max) ->
    Max;
maximum_white_tiles_helper(Tiles, CarpetLen, Index, Current, Max) ->
    {Start, End} = lists:nth(Index + 1, Tiles),
    EndStart = End - Start + 1,

    if EndStart >= CarpetLen then
        NewCurrent = CarpetLen,
        NewMax = max(Max, NewCurrent),
        NewMax
    else
        {NewCurrent, NewIndex} = find_max_coverage(Tiles, CarpetLen, Start, Index),
        NewMax = max(Max, NewCurrent),

        if Index + 1 < length(Tiles) then
            maximum_white_tiles_helper(Tiles, CarpetLen, Index + 1, NewCurrent, NewMax)
        else
            NewMax
        end
    end.

find_max_coverage(Tiles, CarpetLen, Start, Index) ->
    find_max_coverage_helper(Tiles, CarpetLen, Start, Index, Index, 0).

find_max_coverage_helper(Tiles, CarpetLen, Start, Index, CurrentIndex, CurrentCoverage) ->
    if CurrentIndex >= length(Tiles) then
        {CurrentCoverage, Index}
    else
        {NextStart, NextEnd} = lists:nth(CurrentIndex + 1, Tiles),
        CoverageEnd = Start + CarpetLen - 1,

        if NextStart > CoverageEnd then
            {CurrentCoverage, Index}
        else
            NewCoverage = min(CoverageEnd, NextEnd) - NextStart + 1,
            find_max_coverage_helper(Tiles, CarpetLen, Start, Index, CurrentIndex + 1, CurrentCoverage + NewCoverage)
        end
    end.