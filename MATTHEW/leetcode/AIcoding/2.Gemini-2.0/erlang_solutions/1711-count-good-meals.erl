-module(count_good_meals).
-export([count_good_meals/1]).

count_good_meals(Deliciousness) ->
  Len = length(Deliciousness),
  Map = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Deliciousness),
  Result = lists:foldl(fun(D, Acc) ->
    Target = find_target(D, Map),
    Acc + Target
  end, 0, Deliciousness),
  (Result div 2) rem 1000000007.

find_target(D, Map) ->
  TargetSums = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144],
  lists:foldl(fun(Sum, Acc) ->
    Complement = Sum - D,
    case maps:find(Complement, Map) of
      {ok, Count} ->
        if Complement == D then
          Acc + Count - 1
        else
          Acc + Count
        end;
      error ->
        Acc
    end
  end, 0, TargetSums).