-module(minimum_seconds).
-export([minimum_seconds/1]).

minimum_seconds(Nums) ->
  N = length(Nums),
  Counts = lists:foldl(
    fun(Num, Acc) ->
      maps:update_with(Num, fun(X) -> X + 1 end, 1, Acc)
    end,
    maps:new(),
    Nums
  ),
  MaxCount = lists:max([V || _ <- maps:keys(Counts), V <- [maps:get(K, Counts)]]),
  MaxFreq = ceiling(MaxCount / 2),

  MaxDistances =
    lists:map(
      fun(Num) ->
        Indices = lists:foldl(
          fun({Idx, Value}, Acc) ->
            case Value =:= Num of
              true -> [Idx | Acc];
              false -> Acc
            end
          end,
          [],
          lists:zip(lists:seq(1, N), Nums)
        ),
        Distances = lists:map(
          fun(I) ->
            lists:map(
              fun(J) ->
                min(abs(I - J), N - abs(I - J))
              end,
              Indices
            )
          end,
          lists:seq(1, N)
        ),
        lists:max(lists:map(fun(L) -> lists:min(L) end, Distances))
      end,
      maps:keys(Counts)
    ),

  lists:min(MaxDistances).

ceiling(X) ->
  erlang:trunc(X + 0.9999999999999999).