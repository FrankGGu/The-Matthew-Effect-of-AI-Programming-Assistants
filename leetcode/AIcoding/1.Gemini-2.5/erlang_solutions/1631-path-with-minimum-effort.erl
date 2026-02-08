-module(solution).
-export([minimumEffortPath/1]).

minimumEffortPath(Heights) ->
    Rows = length(Heights),
    Cols = length(hd(Heights)),

    Low = 0,
    High = 1000000,

    binary_search(Low, High, Heights, Rows, Cols, High).

binary_search(Low, High, Heights, Rows, Cols, CurrentMinEffort) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case check(Heights, Rows, Cols, Mid) of
        true ->
            binary_search(Low, Mid - 1, Heights, Rows, Cols, Mid);
        false ->
            binary_search(Mid + 1, High, Heights, Rows, Cols, CurrentMinEffort)
    end;
binary_search(_Low, _High, _Heights, _Rows, _Cols, CurrentMinEffort) ->
    CurrentMinEffort.

check(Heights, Rows, Cols, EffortLimit) ->
    Queue = queue:new(),
    Queue1 = queue:in({0,0}, Queue),
    Visited = gb_sets:new(),
    Visited1 = gb_sets:add({0,0}, Visited),

    EndR = Rows - 1,
    EndC = Cols - 1,

    bfs_loop(Queue1, Visited1, Heights, Rows, Cols, EffortLimit, EndR, EndC).

bfs_loop(Queue, _Visited, _Heights, _Rows, _Cols, _EffortLimit, EndR, EndC) when queue:is_empty(Queue) ->
    false;
bfs_loop(Queue, Visited, Heights, Rows, Cols, EffortLimit, EndR, EndC) ->
    {value, {R, C}, NewQueue} = queue:out(Queue),

    if {R, C} == {EndR, EndC} ->
        true;
    true ->
        Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],

        CurrentHeight = get_height(Heights, R, C),

        {FinalQueue, FinalVisited} = lists:foldl(
            fun({NR, NC}, {QAcc, VAcc}) ->
                if 
                    is_valid(NR, NC, Rows, Cols) andalso not gb_sets:is_member({NR, NC}, VAcc) ->
                        NeighborHeight = get_height(Heights, NR, NC),
                        Diff = abs(CurrentHeight - NeighborHeight),
                        if 
                            Diff =< EffortLimit ->
                                {queue:in({NR, NC}, QAcc), gb_sets:add({NR, NC}, VAcc)};
                            true ->
                                {QAcc, VAcc}
                        end;
                    true ->
                        {QAcc, VAcc}
                end
            end,
            {NewQueue, Visited},
            Neighbors
        ),
        bfs_loop(FinalQueue, FinalVisited, Heights, Rows, Cols, EffortLimit, EndR, EndC)
    end.

is_valid(R, C, Rows, Cols) ->
    R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols.

get_height(Heights, R, C) ->
    element(C + 1, element(R + 1, Heights)).