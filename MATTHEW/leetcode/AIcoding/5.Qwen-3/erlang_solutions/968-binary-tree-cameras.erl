-module(btree_cameras).
-export([min_camera_cover/1]).

-record(tn, {val, left, right}).

min_camera_cover(undefined) -> 0;
min_camera_cover(Node) ->
    case cover(Node) of
        {0, _} -> 0;
        {1, _} -> 1;
        {2, _} -> 1
    end.

cover(undefined) -> {0, 0};
cover(#tn{val=Val, left=Left, right=Right}) ->
    {L1, L2} = cover(Left),
    {R1, R2} = cover(Right),
    if
        L1 == 0 orelse R1 == 0 ->
            {1, 1 + L2 + R2};
        L1 == 1 orelse R1 == 1 ->
            {0, L2 + R2};
        true ->
            {2, L2 + R2}
    end.