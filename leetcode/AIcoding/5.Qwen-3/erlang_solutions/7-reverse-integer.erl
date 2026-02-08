-module(reverse_integer).
-export([reverse/1]).

reverse(N) ->
    reverse(N, 0).

reverse(0, Acc) ->
    Acc;
reverse(N, Acc) ->
    reverse(N div 10, Acc * 10 + N rem 10).