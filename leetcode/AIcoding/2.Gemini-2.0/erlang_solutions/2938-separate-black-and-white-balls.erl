-module(separate_balls).
-export([separate_balls/1]).

separate_balls(Balls) ->
    separate_balls(Balls, 0, 0).

separate_balls([], Count, Acc) ->
    Acc;
separate_balls([0 | Rest], Count, Acc) ->
    separate_balls(Rest, Count + 1, Acc + Count);
separate_balls([1 | Rest], Count, Acc) ->
    separate_balls(Rest, Count, Acc).