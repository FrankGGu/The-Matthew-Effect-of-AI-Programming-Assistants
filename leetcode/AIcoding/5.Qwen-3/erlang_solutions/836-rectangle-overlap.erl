-module(rectangle_overlap).
-export([overlaps/2]).

overlaps(A, B) ->
    X1 = hd(A),
    Y1 = lists:nth(2, A),
    X2 = lists:nth(3, A),
    Y2 = lists:nth(4, A),
    X3 = hd(B),
    Y3 = lists:nth(2, B),
    X4 = lists:nth(3, B),
    Y4 = lists:nth(4, B),
    not (X2 <= X3 orelse X4 <= X1 orelse Y2 <= Y3 orelse Y4 <= Y1).