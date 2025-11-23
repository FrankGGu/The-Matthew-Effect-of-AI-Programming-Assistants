-module(solution).
-export([earliest_possible_day_of_full_bloom/2]).

earliest_possible_day_of_full_bloom(PlantTime, GrowTime) ->
    Flowers = lists:zip(GrowTime, PlantTime),
    SortedFlowers = lists:sort(fun({GT1, _PT1}, {GT2, _PT2}) -> GT1 >= GT2 end, Flowers),
    {_FinalPlantTime, MaxBloomTime} = lists:foldl(
        fun({GrowT, PlantT}, {AccPlantTime, AccMaxBloomTime}) ->
            NewPlantTime = AccPlantTime + PlantT,
            BloomTimeForThisFlower = NewPlantTime + GrowT,
            NewMaxBloomTime = max(AccMaxBloomTime, BloomTimeForThisFlower),
            {NewPlantTime, NewMaxBloomTime}
        end,
        {0, 0},
        SortedFlowers
    ),
    MaxBloomTime.