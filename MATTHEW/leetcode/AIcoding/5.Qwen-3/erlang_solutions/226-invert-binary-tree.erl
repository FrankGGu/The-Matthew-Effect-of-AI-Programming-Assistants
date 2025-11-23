-module(invert_binary_tree).
-export([invert/1]).

-record(tree, {val, left, right}).

invert(nil) ->
    nil;
invert(#tree{val=Val, left=Left, right=Right}) ->
    #tree{val=Val, left=invert(Right), right=invert(Left)}.