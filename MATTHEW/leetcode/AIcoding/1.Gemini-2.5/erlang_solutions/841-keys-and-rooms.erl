-module(solution).
-export([canVisitAllRooms/1]).

canVisitAllRooms(Rooms) ->
    N = length(Rooms),
    InitialVisited = gb_sets:add(0, gb_sets:new()),
    % Queue is represented by {InList, OutList}
    % InList: elements added recently, in reverse order
    % OutList: elements to be processed next, in correct order
    InitialQueue = {[], [0]}, % Start with room 0

    bfs(InitialQueue, InitialVisited, Rooms, N).

bfs({In, []}, Visited, Rooms, N) when In == [] ->
    % Both In and Out are empty, no more rooms to visit
    gb_sets:size(Visited) == N;
bfs({In, []}, Visited, Rooms, N) ->
    % Out is empty, transfer In to Out
    bfs({[], lists:reverse(In)}, Visited, Rooms, N);
bfs({In, [CurrentRoom | Out]}, Visited, Rooms, N) ->
    % Process CurrentRoom
    % Get keys for CurrentRoom (adjust for 0-indexing to 1-indexing for lists:nth)
    Keys = lists:nth(CurrentRoom + 1, Rooms),

    {NewIn, NewVisited} = lists:foldl(
        fun(Key, {AccIn, AccVisited}) ->
            if gb_sets:is_member(Key, AccVisited) ->
                {AccIn, AccVisited};
            true ->
                { [Key | AccIn], gb_sets:add(Key, AccVisited) }
            end
        end,
        {In, Visited},
        Keys
    ),

    bfs({NewIn, Out}, NewVisited, Rooms, N).