-module(sudoku).
-export([valid_sudoku/1]).

valid_sudoku(Board) ->
    Rows = lists:map(fun(Row) -> Row end, Board),
    Cols = lists:map(fun(I) -> lists:foldl(fun(J, Acc) -> [lists:nth(I, lists:nth(J, Board))] ++ Acc end, [], lists:seq(0, 8)) end, lists:seq(0, 8)),
    Boxes = lists:map(fun(B) -> 
        lists:flatmap(fun(I) -> 
            lists:flatmap(fun(J) -> 
                [lists:nth(B*3 + I, lists:nth(J*3, Board))] 
            end, lists:seq(0, 2)) 
        end, lists:seq(0, 2)) 
    end, lists:seq(0, 8)),
    check(Rows) and check(Cols) and check(Boxes).

check(Lists) ->
    lists:all(fun(List) -> 
        lists:all(fun(X) -> X /= "." end, List) andalso 
        lists:usort(List) == List 
    end, Lists).