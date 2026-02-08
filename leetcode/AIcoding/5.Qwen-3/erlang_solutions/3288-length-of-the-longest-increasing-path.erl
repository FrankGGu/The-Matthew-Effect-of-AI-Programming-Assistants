-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            DP = array:new({1, Rows}, {1, Cols}, 0),
            MaxPath = 0,
            lists:foreach(fun(I) -> 
                lists:foreach(fun(J) -> 
                    Path = dfs(Matrix, I, J, DP, Rows, Cols),
                    if Path > MaxPath -> MaxPath = Path; true -> ok end
                end, lists:seq(0, Cols-1))
            end, lists:seq(0, Rows-1)),
            MaxPath
    end.

dfs(Matrix, I, J, DP, Rows, Cols) ->
    if
        array:get({I+1, J+1}, DP) /= 0 -> array:get({I+1, J+1}, DP);
        true ->
            Max = 1,
            Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
            lists:foreach(fun({DI, DJ}) ->
                NI = I + DI,
                NJ = J + DJ,
                if
                    NI >= 0, NI < Rows, NJ >= 0, NJ < Cols, element(I+1, Matrix) =< element(NI+1, Matrix) -> ok;
                    true -> ok
                end,
                if
                    NI >= 0, NI < Rows, NJ >= 0, NJ < Cols, element(I+1, Matrix) < element(NI+1, Matrix) ->
                        Path = 1 + dfs(Matrix, NI, NJ, DP, Rows, Cols),
                        if Path > Max -> Max = Path; true -> ok end;
                    true -> ok
                end
            end, Directions),
            array:set({I+1, J+1}, Max, DP),
            Max
    end.