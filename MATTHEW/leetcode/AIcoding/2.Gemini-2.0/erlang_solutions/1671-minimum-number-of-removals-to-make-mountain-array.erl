-module(minimum_mountain_removals).
-export([minimum_mountain_removals/1]).

minimum_mountain_removals(Nums) ->
  N = length(Nums),
  Lis = longest_increasing_subsequence(Nums),
  Lds = longest_decreasing_subsequence(Nums),
  MaxLen = 0,
  for(I <- 1 to N,
      begin
        if Lis[I] > 1 and Lds[I] > 1 then
          MaxLen1 = Lis[I] + Lds[I] - 1,
          MaxLen = max(MaxLen, MaxLen1)
        else
          MaxLen = MaxLen
        end
      end),
  N - MaxLen.

longest_increasing_subsequence(Nums) ->
  N = length(Nums),
  Lis = lists:duplicate(N, 1),
  for(I <- 2 to N,
      for(J <- 1 to I - 1,
          begin
            if Nums[I] > Nums[J] then
              Lis[I] := max(Lis[I], Lis[J] + 1)
            else
              Lis[I] := Lis[I]
            end
          end)),
  Lis.

longest_decreasing_subsequence(Nums) ->
  N = length(Nums),
  Lds = lists:duplicate(N, 1),
  for(I <- N - 1 to 1 by -1,
      for(J <- I + 1 to N,
          begin
            if Nums[I] > Nums[J] then
              Lds[I] := max(Lds[I], Lds[J] + 1)
            else
              Lds[I] := Lds[I]
            end
          end)),
  Lds.

for(Start, End, Fun) ->
  for(Start, End, 1, Fun).

for(Start, End, Step, Fun) ->
  for(Start, End, Step, Fun, ok).

for(Start, End, Step, Fun, Acc) ->
  if Start > End then
    Acc
  else
    NewAcc = Fun(Start),
    for(Start + Step, End, Step, Fun, NewAcc)
  end.