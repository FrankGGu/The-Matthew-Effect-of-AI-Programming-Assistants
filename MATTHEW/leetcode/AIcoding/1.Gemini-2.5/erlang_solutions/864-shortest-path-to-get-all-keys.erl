-module(solution).
-export([shortestPathAllKeys/1]).

shortestPathAllKeys(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    GridChars = [string:to_list(RowStr) || RowStr <- Grid],

    {StartR, StartC, TotalKeysMask} = find_start_and_keys(GridChars, Rows, Cols),

    Queue = queue:in({0, StartR, StartC, 0}, queue:new()),
    Visited = gb_sets:add({StartR, StartC, 0}, gb_sets:empty()),

    bfs(Queue, Visited, GridChars, Rows, Cols, TotalKeysMask).

bfs(Queue, Visited, GridChars, Rows, Cols, TotalKeysMask) ->
    case queue:out(Queue) of
        {{value, {Steps, R, C, Keys}}, RestQueue} ->
            if Keys == TotalKeysMask ->
                Steps;
            true ->
                Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],
                {NewQueue, NewVisited} = lists:foldl(fun({NR, NC}, {AccQueue, AccVisited}) ->
                    if NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                        RowList = lists:nth(NR + 1, GridChars),
                        Char = lists:nth(NC + 1, RowList),

                        case Char of
                            $# -> {AccQueue, AccVisited};
                            $. ->
                                if gb_sets:is_element({NR, NC, Keys}, AccVisited) -> {AccQueue, AccVisited};
                                true ->
                                    {queue:in({Steps + 1, NR, NC, Keys}, AccQueue), gb_sets:add({NR, NC, Keys}, AccVisited)}
                                end;
                            $@ ->
                                if gb_sets:is_element({NR, NC, Keys}, AccVisited) -> {AccQueue, AccVisited};
                                true ->
                                    {queue:in({Steps + 1, NR, NC, Keys}, AccQueue), gb_sets:add({NR, NC, Keys}, AccVisited)}
                                end;
                            _ when Char >= $a andalso Char =< $f ->
                                KeyBit = 1 bsl (Char - $a),
                                NewKeys = Keys bor KeyBit,
                                if gb_sets:is_element({NR, NC, NewKeys}, AccVisited) -> {AccQueue, AccVisited};
                                true ->
                                    {queue:in({Steps + 1, NR, NC, NewKeys}, AccQueue), gb_sets:add({NR, NC, NewKeys}, AccVisited)}
                                end;
                            _ when Char >= $A andalso Char =< $F ->
                                LockBit = 1 bsl (Char - $A),
                                if (Keys band LockBit) /= 0 ->
                                    if gb_sets:is_element({NR, NC, Keys}, AccVisited) -> {AccQueue, AccVisited};
                                    true ->
                                        {queue:in({Steps + 1, NR, NC, Keys}, AccQueue), gb_sets:add({NR, NC, Keys}, AccVisited)}
                                    end;
                                true -> {AccQueue, AccVisited}
                                end;
                            _ -> {AccQueue, AccVisited}
                        end
                    else
                        {AccQueue, AccVisited}
                    end
                end, {RestQueue, Visited}, Neighbors),
                bfs(NewQueue, NewVisited, GridChars, Rows, Cols, TotalKeysMask)
            end;
        {empty, _} ->
            -1
    end.

find_start_and_keys(GridChars, Rows, Cols) ->
    InitialState = {-1, -1, 0},
    lists:foldl(fun(R_idx, {AccStartR, AccStartC, AccTotalKeysMask}) ->
        RowList = lists:nth(R_idx + 1, GridChars),
        lists:foldl(fun(C_idx, {InnerAccStartR, InnerAccStartC, InnerAccTotalKeysMask}) ->
            Char = lists:nth(C_idx + 1, RowList),
            case Char of
                $@ -> {R_idx, C_idx, InnerAccTotalKeysMask};
                _ when Char >= $a andalso Char =< $f ->
                    KeyBit = 1 bsl (Char - $a),
                    {InnerAccStartR, InnerAccStartC, InnerAccTotalKeysMask bor KeyBit};
                _ -> {InnerAccStartR, InnerAccStartC, InnerAccTotalKeysMask}
            end
        end, {AccStartR, AccStartC, AccTotalKeysMask}, lists:seq(0, Cols - 1))
    end, InitialState, lists:seq(0, Rows - 1)).