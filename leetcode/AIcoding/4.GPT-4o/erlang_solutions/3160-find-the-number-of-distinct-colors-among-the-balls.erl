-module(solution).
-export([countDistinctColors/1]).

countDistinctColors(Balls) ->
    BallsSet = sets:from_list(Balls),
    sets:size(BallsSet).