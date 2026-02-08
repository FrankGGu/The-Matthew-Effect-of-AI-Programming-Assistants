-module(fresh_donuts).
-export([max_happy_groups/2]).

max_happy_groups(batchSize, groups) ->
  Len = length(groups),
  Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X rem batchSize, fun(V) -> V + 1 end, 1, Acc) end, #{}, groups),
  max_happy_groups_helper(batchSize, Counts, Len, 0).

max_happy_groups_helper(_BatchSize, Counts, 0, Happy) ->
  Happy;
max_happy_groups_helper(BatchSize, Counts, Len, Happy) ->
  case maps:get(0, Counts, 0) of
    0 ->
      NextCounts = Counts;
      NextHappy = Happy;
    N ->
      NextCounts = maps:update(0, N - 1, Counts);
      NextHappy = Happy + 1
  end,

  lists:foldl(fun(Remainder, {MaxHappy, BestCounts}) ->
                  case maps:get(Remainder, NextCounts, 0) of
                    0 ->
                      {MaxHappy, BestCounts};
                    N ->
                      NewCounts = maps:update(Remainder, N - 1, NextCounts),
                      OtherRemainders = [I || I <- lists:seq(1, BatchSize - 1), I /= Remainder],
                      {NewMaxHappy, NewBestCounts} = try_all_combinations(BatchSize, NewCounts, Remainder, OtherRemainders, Len - 1, NextHappy),

                      case NewMaxHappy > MaxHappy of
                        true ->
                          {NewMaxHappy, NewBestCounts};
                        false ->
                          {MaxHappy, BestCounts}
                      end
                  end
              end, {0, #{}}, lists:seq(1, BatchSize - 1)).

try_all_combinations(_BatchSize, Counts, Remainder, [], Len, Happy) ->
  NewHappy = Happy + 1,
  {NewHappy, Counts};
try_all_combinations(BatchSize, Counts, Remainder, [OtherRemainder | OtherRemainders], Len, Happy) ->
  case maps:get(OtherRemainder, Counts, 0) of
    0 ->
      try_all_combinations(BatchSize, Counts, Remainder, OtherRemainders, Len, Happy);
    N ->
      NewCounts = maps:update(OtherRemainder, N - 1, Counts),
      NewRemainder = (Remainder + OtherRemainder) rem BatchSize,

      case NewRemainder == 0 of
        true ->
          try_all_combinations(BatchSize, NewCounts, 0, OtherRemainders, Len, Happy + 1);
        false ->
          try_all_combinations(BatchSize, NewCounts, NewRemainder, OtherRemainders, Len, Happy)
      end
  end.