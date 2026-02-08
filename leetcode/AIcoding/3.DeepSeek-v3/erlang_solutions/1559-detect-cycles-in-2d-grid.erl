-module(solution).
-export([containsCycle/1]).

containsCycle(Grid) ->
    Rows = length(Grid),
    if Rows == 0 -> false;
       true ->
           Cols = length(hd(Grid)),
           Visited = sets:new(),
           lists:any(fun({I, J}) -> 
                          not sets:is_element({I, J}, Visited) andalso
                          dfs(Grid, I, J, -1, -1, Grid:get(I, J), Visited, Rows, Cols)
                      end,
                      [{I, J} || I <- lists:seq(0, Rows-1), J <- lists:seq(0, Cols-1)])
    end.

dfs(Grid, I, J, PI, PJ, C, Visited, Rows, Cols) ->
    case I < 0 orelse I >= Rows orelse J < 0 orelse J >= Cols orelse Grid:get(I, J) =/= C of
        true -> false;
        false ->
            case sets:is_element({I, J}, Visited) of
                true -> true;
                false ->
                    NewVisited = sets:add_element({I, J}, Visited),
                    ((I+1 =/= PI orelse J =/= PJ) andalso dfs(Grid, I+1, J, I, J, C, NewVisited, Rows, Cols)) orelse
                    ((I-1 =/= PI orelse J =/= PJ) andalso dfs(Grid, I-1, J, I, J, C, NewVisited, Rows, Cols)) orelse
                    ((I =/= PI orelse J+1 =/= PJ) andalso dfs(Grid, I, J+1, I, J, C, NewVisited, Rows, Cols)) orelse
                    ((I =/= PI orelse J-1 =/= PJ) andalso dfs(Grid, I, J-1, I, J, C, NewVisited, Rows, Cols))
            end
    end.