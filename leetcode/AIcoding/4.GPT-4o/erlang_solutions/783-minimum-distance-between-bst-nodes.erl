-module(solution).
-export([min_diff_in_bst/1]).

-record(node, {val, left = null, right = null}).

min_diff_in_bst(Root) ->
    {MinDiff, _Prev} = min_diff(Root, undefined),
    MinDiff.

min_diff(null, Prev) -> {infinity, Prev};
min_diff(#node{val=Val, left=Left, right=Right}, Prev) ->
    {LeftDiff, NewPrev} = min_diff(Left, Prev),
    NewDiff = case NewPrev of
                  undefined -> infinity;
                  _ -> abs(Val - NewPrev)
              end,
    {RightDiff, LastPrev} = min_diff(Right, Val),
    MinDiff = min(LeftDiff, min(NewDiff, RightDiff)),
    {MinDiff, LastPrev}.