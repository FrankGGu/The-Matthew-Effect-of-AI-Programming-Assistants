-module(minimum_cost_to_split_an_array).
-export([minimum_cost/2]).

minimum_cost(Nums, K) ->
  N = length(Nums),
  memo(Nums, K, 0, N - 1, dict:new()).

memo(Nums, K, L, R, Memo) ->
  case dict:find({L, R}, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Result = calculate_cost(Nums, K, L, R, Memo),
      NewMemo = dict:store({L, R}, Result, Memo),
      Result
  end.

calculate_cost(Nums, K, L, R, Memo) ->
  if L > R ->
    0;
  true ->
    Cost = calculate_trim_cost(Nums, L, R),
    MinCost = lists:foldl(
                fun(I, Acc) ->
                  Min1 = memo(Nums, K, L, I - 1, Memo),
                  Min2 = memo(Nums, K, I, R, Memo),
                  min(Acc, Min1 + Min2)
                end,
                infinity,
                lists:seq(L + 1, R)
              ),
    K + Cost + (if MinCost == infinity -> 0; true -> MinCost end)
  end.

calculate_trim_cost(Nums, L, R) ->
  CountDict = lists:foldl(
                fun(I, Acc) ->
                  Num = lists:nth(I + 1, Nums),
                  case dict:find(Num, Acc) of
                    {ok, Cnt} ->
                      dict:store(Num, Cnt + 1, Acc);
                    error ->
                      dict:store(Num, 1, Acc)
                  end
                end,
                dict:new(),
                lists:seq(L, R)
              ),
  dict:fold(
    fun(_Key, Value, Acc) ->
      if Value > 1 ->
        Acc + 1;
      true ->
        Acc
      end
    end,
    0,
    CountDict
  ).