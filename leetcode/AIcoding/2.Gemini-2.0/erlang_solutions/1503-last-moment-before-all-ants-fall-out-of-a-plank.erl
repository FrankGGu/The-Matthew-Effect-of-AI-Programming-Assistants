-module(last_moment).
-export([last_moment/2]).

last_moment(N, Left, Right) ->
  MaxLeft = lists:max([0 | Left]),
  MinRight = lists:min([N | Right]),
  max(MaxLeft, N - MinRight).