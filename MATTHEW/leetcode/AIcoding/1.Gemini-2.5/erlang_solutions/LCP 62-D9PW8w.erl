-module(solution).
-export([trafficHub/2]).

-include_lib("kernel/include/array.hrl").

trafficHub(N, Edges) ->
    InDegrees = array:new({size, N, default, 0}),
    OutDegrees = array:new({size, N, default, 0}),

    {FinalInDegrees, FinalOutDegrees} = lists:foldl(
        fun([From, To], {AccIn, AccOut}) ->
            NewAccOut = array:set(From, array:get(From, AccOut) + 1, AccOut),
            NewAccIn = array:set(To, array:get(To, AccIn) + 1, AccIn),
            {NewAccIn, NewAccOut}
        end,
        {InDegrees, OutDegrees},
        Edges
    ),

    TargetInDegree = N - 1,

    find_hub(0, N, TargetInDegree, FinalInDegrees, FinalOutDegrees).

find_hub(Node, N, TargetInDegree, InDegrees, OutDegrees) when Node < N ->
    In = array:get(Node, InDegrees),
    Out = array:get(Node, OutDegrees),

    if
        In == TargetInDegree andalso Out == 0 ->
            Node;
        true ->
            find_hub(Node + 1, N, TargetInDegree, InDegrees, OutDegrees)
    end;
find_hub(_Node, _N, _TargetInDegree, _InDegrees, _OutDegrees) ->
    -1.