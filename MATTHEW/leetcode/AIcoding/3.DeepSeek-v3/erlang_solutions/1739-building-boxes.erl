-spec minimum_boxes(N :: integer()) -> integer().
minimum_boxes(N) ->
    minimum_boxes(N, 1, 1, 1).

minimum_boxes(N, Level, BoxesInLevel, TotalBoxes) when TotalBoxes >= N ->
    BoxesInLevel - (TotalBoxes - N);
minimum_boxes(N, Level, BoxesInLevel, TotalBoxes) ->
    NewLevel = Level + 1,
    NewBoxesInLevel = BoxesInLevel + NewLevel,
    NewTotalBoxes = TotalBoxes + NewBoxesInLevel,
    minimum_boxes(N, NewLevel, NewBoxesInLevel, NewTotalBoxes).