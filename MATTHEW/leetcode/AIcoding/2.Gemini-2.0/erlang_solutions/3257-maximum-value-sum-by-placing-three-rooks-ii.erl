-module(maximum_value_sum_by_placing_three_rooks_ii).
-export([solve/1]).

solve(Board) ->
  {Rows, Cols} = get_dimensions(Board),
  MaxVal = -1,
  for(I1 = 0, I1 < Rows, I1 + 1,
    for(J1 = 0, J1 < Cols, J1 + 1,
      for(I2 = 0, I2 < Rows, I2 + 1,
        for(J2 = 0, J2 < Cols, J2 + 1,
          for(I3 = 0, I3 < Rows, I3 + 1,
            for(J3 = 0, J3 < Cols, J3 + 1,
              begin
                if distinct(I1, J1, I2, J2, I3, J3, Rows, Cols) then
                  Val = Board[I1][J1] + Board[I2][J2] + Board[I3][J3],
                  MaxVal1 = max(MaxVal, Val),
                  MaxVal = MaxVal1
                else
                  MaxVal
                end
              end
            )
          )
        )
      )
    )
  ),
  MaxVal.

get_dimensions(Board) ->
  Rows = length(Board),
  Cols = length(lists:nth(1, Board)),
  {Rows, Cols}.

distinct(I1, J1, I2, J2, I3, J3, Rows, Cols) ->
  (I1 * Cols + J1) /= (I2 * Cols + J2) andalso
  (I1 * Cols + J1) /= (I3 * Cols + J3) andalso
  (I2 * Cols + J2) /= (I3 * Cols + J3) andalso
  not (I1 == I2 and J1 == J2) andalso
  not (I1 == I3 and J1 == J3) andalso
  not (I2 == I3 and J2 == J3) andalso
  not (I1 == I2 or J1 == J2) andalso
  not (I1 == I3 or J1 == J3) andalso
  not (I2 == I3 or J2 == J3).