-module(zero_one_matrix).
-export([update_matrix/1]).

update_matrix(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Dist = lists:duplicate(Rows, lists:duplicate(Cols, 10000)),

  % Forward pass
  for(I, 1, Rows,
    for(J, 1, Cols,
      fun(I, J) ->
        if Matrix[[I-1, J-1]] == 0 ->
          Dist[[I-1, J-1]] = 0;
        else
          Up = if I > 1 then Dist[[I-2, J-1]] + 1 else 10000 end,
          Left = if J > 1 then Dist[[I-1, J-2]] + 1 else 10000 end,
          Dist[[I-1, J-1]] = min(Up, Left)
        end
      end
    )
  ),

  % Backward pass
  for(I, Rows, -1, 1,
    for(J, Cols, -1, 1,
      fun(I, J) ->
        Down = if I < Rows then Dist[[I, J-1]] + 1 else 10000 end,
        Right = if J < Cols then Dist[[I-1, J]] + 1 else 10000 end,
        Dist[[I-1, J-1]] = min(Dist[[I-1, J-1]], min(Down, Right))
      end
    )
  ),

  Dist.

for(I, Start, End, Step, Fun) ->
  for_helper(I, Start, End, Step, Fun).

for_helper(I, Start, End, Step, Fun) when (Step > 0 and I > End) or (Step < 0 and I < End) ->
  ok;
for_helper(I, Start, End, Step, Fun) ->
  for_helper(I + Step, Start, End, Step, Fun(I)).