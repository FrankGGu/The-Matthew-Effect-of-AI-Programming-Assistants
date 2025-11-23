-module(supply_truck).
-export([minimumEffort/1]).

minimumEffort(Obstacles) ->
    Rows = length(Obstacles),
    Cols = length(hd(Obstacles)),
    {X, Y} = {Rows - 1, Cols - 1},
    Dirs = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    Heap = erl_heap:new(),
    Efforts = array:new({size, Rows * Cols}, {default, 1000000}),
    Efforts2 = array:set(0, 0, Efforts),
    erl_heap:insert(Heap, {0, 0, 0}),
    do_search(Heap, Efforts2, Obstacles, Rows, Cols, X, Y, Dirs).

do_search(Heap, Efforts, _Obstacles, _Rows, _Cols, X, Y, _Dirs) when Heap == [] ->
    array:get(X * _Cols + Y, Efforts);

do_search(Heap, Efforts, Obstacles, Rows, Cols, X, Y, Dirs) ->
    {Effort, R, C} = erl_heap:pop(Heap),
    Index = R * Cols + C,
    if
        Effort > array:get(Index, Efforts) ->
            do_search(Heap, Efforts, Obstacles, Rows, Cols, X, Y, Dirs);
        true ->
            case {R, C} of
                {X, Y} -> Effort;
                _ ->
                    lists:foreach(
                        fun({DR, DC}) ->
                            NR = R + DR,
                            NC = C + DC,
                            if
                                NR >= 0, NR < Rows, NC >= 0, NC < Cols ->
                                    NewEffort = max(Effort, abs(array:get(NR * Cols + NC, Obstacles) - array:get(R * Cols + C, Obstacles))),
                                    if
                                        NewEffort < array:get(NR * Cols + NC, Efforts) ->
                                            Efforts2 = array:set(NR * Cols + NC, NewEffort, Efforts),
                                            Heap2 = erl_heap:insert(Heap, {NewEffort, NR, NC}),
                                            do_search(Heap2, Efforts2, Obstacles, Rows, Cols, X, Y, Dirs);
                                        true ->
                                            do_search(Heap, Efforts, Obstacles, Rows, Cols, X, Y, Dirs)
                                    end;
                                true ->
                                    do_search(Heap, Efforts, Obstacles, Rows, Cols, X, Y, Dirs)
                            end
                        end,
                        Dirs
                    )
            end
    end.