-module(equal_frequency_submatrices).
-export([count_submatrices/3]).

count_submatrices(Matrix, X, Y) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  count_submatrices_helper(Matrix, X, Y, Rows, Cols).

count_submatrices_helper(Matrix, X, Y, Rows, Cols) ->
  count_submatrices_recursive(Matrix, X, Y, Rows, Cols, 0, 0, 0).

count_submatrices_recursive(Matrix, X, Y, Rows, Cols, R1, C1, Count) ->
  if R1 >= Rows then
    Count
  else
    NewCount = count_submatrices_col(Matrix, X, Y, Rows, Cols, R1, C1, Count, R1, C1),
    NewC1 = C1 + 1,
    if NewC1 >= Cols then
      NewR1 = R1 + 1,
      count_submatrices_recursive(Matrix, X, Y, Rows, Cols, NewR1, 0, NewCount)
    else
      count_submatrices_recursive(Matrix, X, Y, Rows, Cols, R1, NewC1, NewCount)
    end
  end.

count_submatrices_col(Matrix, X, Y, Rows, Cols, R1, C1, Count, R2, C2) ->
  if R2 >= Rows then
    Count
  else
    NewCount = count_submatrices_row(Matrix, X, Y, Rows, Cols, R1, C1, Count, R2, C2),
    NewR2 = R2 + 1,
    count_submatrices_col(Matrix, X, Y, Rows, Cols, R1, C1, NewCount, NewR2, C2)
  end.

count_submatrices_row(Matrix, X, Y, Rows, Cols, R1, C1, Count, R2, C2) ->
  if C2 >= Cols then
    Count
  else
    Submatrix = get_submatrix(Matrix, R1, C1, R2, C2),
    XCount = count_element(Submatrix, X),
    YCount = count_element(Submatrix, Y),
    NewCount = if XCount == YCount then
                 Count + 1
               else
                 Count
               end,
    NewC2 = C2 + 1,
    count_submatrices_row(Matrix, X, Y, Rows, Cols, R1, C1, NewCount, R2, NewC2)
  end.

get_submatrix(Matrix, R1, C1, R2, C2) ->
  [get_row_slice(Row, C1, C2) || Row <- lists:sublist(Matrix, R1 + 1, R2 - R1 + 1)].

get_row_slice(Row, C1, C2) ->
  lists:sublist(Row, C1 + 1, C2 - C1 + 1).

count_element(Submatrix, Element) ->
  count_element_helper(Submatrix, Element, 0).

count_element_helper([], _Element, Count) ->
  Count;
count_element_helper([Row|Rest], Element, Count) ->
  NewCount = count_element_in_row(Row, Element, Count),
  count_element_helper(Rest, Element, NewCount).

count_element_in_row([], _Element, Count) ->
  Count;
count_element_in_row([H|T], Element, Count) ->
  NewCount = if H == Element then
               Count + 1
             else
               Count
             end,
  count_element_in_row(T, Element, NewCount).