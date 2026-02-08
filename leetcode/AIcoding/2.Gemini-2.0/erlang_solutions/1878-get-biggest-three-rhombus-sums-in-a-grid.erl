-module(biggest_rhombus_sums).
-export([get_biggest_three_rhombus_sums/1]).

get_biggest_three_rhombus_sums(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Sums = sets:new(),
    for(Row, 0, Rows - 1,
        for(Col, 0, Cols - 1,
            lists:foreach(fun(Size) ->
                                  Sum = rhombus_sum(Grid, Row, Col, Size),
                                  sets:add_element(Sum, Sums)
                          end, lists:seq(0, min(min(Row, Rows - 1 - Row), min(Col, Cols - 1 - Col))))
        )
    ),
    Sorted = lists:sort(fun(A, B) -> A > B end, sets:to_list(Sums)),
    lists:sublist(Sorted, 1, min(3, length(Sorted))).

rhombus_sum(Grid, Row, Col, Size) ->
    if Size == 0 then
        lists:nth(Col + 1, lists:nth(Row + 1, Grid))
    else
        sum_rhombus(Grid, Row, Col, Size, 0)
    end.

sum_rhombus(Grid, Row, Col, Size, Acc) ->
    Sum1 = sum_side(Grid, Row, Col, Size, 1, 0, Acc),
    Sum2 = sum_side(Grid, Row + Size, Col + Size, Size, -1, 0, Sum1),
    Sum3 = sum_side(Grid, Row, Col + 2 * Size, Size, -1, 1, Sum2),
    Sum4 = sum_side(Grid, Row - Size, Col + Size, Size, 1, 1, Sum3) - lists:nth(Col + 1, lists:nth(Row + 1, Grid)) - lists:nth(Col + 2 * Size + 1, lists:nth(Row + 1, Grid)) - lists:nth(Col + Size + 1, lists:nth(Row - 2 * Size + 1, Grid)),
    Sum4.

sum_side(Grid, Row, Col, Size, RowDir, ColDir, Acc) ->
    lists:foldl(fun(I, Acc1) ->
                        Acc1 + lists:nth(Col + I * ColDir + 1, lists:nth(Row + I * RowDir + 1, Grid))
                end, Acc, lists:seq(0, Size)).

for(Var, From, To, Body) ->
  for(Var, From, To, 1, Body).

for(Var, From, To, Step, Body) ->
  case From > To of
    true ->
      true;
    false ->
      Body(From),
      for(Var, From + Step, To, Step, Body)
  end.