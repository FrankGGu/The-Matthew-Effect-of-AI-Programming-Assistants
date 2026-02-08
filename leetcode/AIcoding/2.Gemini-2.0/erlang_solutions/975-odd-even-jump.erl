-module(odd_even_jump).
-export([odd_even_jump/1]).

odd_even_jump(Arr) ->
  N = length(Arr),
  {Odd, Even} = calculate_jumps(Arr, N),
  count_good_indices(Arr, N, Odd, Even).

calculate_jumps(Arr, N) ->
  Odd = array:new([N, N], {default, false}),
  Even = array:new([N, N], {default, false}),

  Odd = array:set(N - 1, true, Odd),
  Even = array:set(N - 1, true, Even),

  for(I <- N - 2 to 0 by -1) do
    {OddI, EvenI} = find_next_jumps(Arr, I, N);

    if OddI =/= -1 then
      Odd = array:set(I, array:get(OddI, Even), Odd)
    end,

    if EvenI =/= -1 then
      Even = array:set(I, array:get(EvenI, Odd), Even)
    end
  end,
  {array:export(Odd), array:export(Even)}.

find_next_jumps(Arr, I, N) ->
  OddI = -1,
  EvenI = -1,
  MinDiff = infinity,
  MaxDiff = infinity,

  for(J <- I + 1 to N - 1) do
    Diff = lists:nth(J + 1, Arr) - lists:nth(I + 1, Arr),
    if Diff >= 0 andalso Diff < MinDiff then
      MinDiff = Diff,
      OddI = J
    end,
    if Diff <= 0 andalso -Diff < MaxDiff then
      MaxDiff = -Diff,
      EvenI = J
    end
  end,
  {OddI, EvenI}.

count_good_indices(Arr, N, Odd, Even) ->
  count_good_indices_helper(Arr, N, Odd, Even, 0, 0).

count_good_indices_helper(_Arr, N, Odd, _Even, N, Acc) ->
  Acc;
count_good_indices_helper(Arr, N, Odd, Even, I, Acc) ->
  NextAcc = case lists:nth(I + 1, Odd) of
              true -> Acc + 1;
              false -> Acc
            end,
  count_good_indices_helper(Arr, N, Odd, Even, I + 1, NextAcc).

infinity() -> 1000000000.