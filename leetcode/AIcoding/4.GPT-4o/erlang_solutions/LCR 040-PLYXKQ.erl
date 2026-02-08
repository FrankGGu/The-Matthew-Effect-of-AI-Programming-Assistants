-module(solution).
-export([maximalRectangle/1]).

maximalRectangle(Matrix) ->
    case Matrix of
        [] -> 0;
        _ -> 
            H = length(Matrix),
            W = length(hd(Matrix)),
            Hist = lists:foldl(fun(Row, Acc) -> 
                lists:zip_with(fun(X, Y) -> 
                    if X =:= 1 -> Y + 1; true -> 0 end 
                end, Row, Acc) 
            end, lists:duplicate(W, 0), Matrix),
            lists:max(lists:map(fun(Row) -> largestRectangleArea(Row) end, Hist))
    end.

largestRectangleArea(Heights) ->
    Indices = [],
    Heights1 = [0 | Heights] ++ [0],
    lists:foldl(fun(H, Acc) -> 
        case Acc of
            [] -> [{H, 0}];
            [{_, LastIndex} | _] = Stack when H >= elem(0, hd(Stack)) -> 
                [{H, LastIndex} | tl(Stack)];
            _ -> 
                Area = (lists:nth(1, hd(Acc)) - lists:nth(1, hd(tl(Acc)))) * elem(0, hd(Acc)),
                Max = max(Area, largestRectangleArea(tl(Acc))),
                [{H, LastIndex} | Acc]
        end
    end, [], Heights1)
    |> lists:max().

max(A, B) -> 
    if A > B -> A; true -> B end.