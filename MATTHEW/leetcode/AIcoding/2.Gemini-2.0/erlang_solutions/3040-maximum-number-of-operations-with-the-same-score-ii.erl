-module(maxOperations).
-export([maxOperations/1]).

maxOperations(Nums) ->
  N = length(Nums),
  memo_init(N, Memo),
  maxOperations_helper(Nums, 0, N - 1, Memo).

maxOperations_helper(Nums, L, R, Memo) ->
  case maps:get(L * 1000 + R, Memo, undefined) of
    undefined ->
      Res =
        case L >= R of
          true ->
            0;
          false ->
            Val1 = element(1, lists:nth(L * 1000 + R + 1, Memo)),
            Val2 = element(2, lists:nth(L * 1000 + R + 1, Memo)),
            Val3 = element(3, lists:nth(L * 1000 + R + 1, Memo)),

            V1 = lists:nth(L + 1, Nums) + lists:nth(L + 2, Nums),
            V2 = lists:nth(R, Nums) + lists:nth(R + 1, Nums),
            V3 = lists:nth(L + 1, Nums) + lists:nth(R + 1, Nums),

            M1 =
              if
                L + 1 >= R ->
                  0;
                true ->
                  maxOperations_helper(Nums, L + 2, R, Memo)
              end,

            M2 =
              if
                L >= R - 1 ->
                  0;
                true ->
                  maxOperations_helper(Nums, L, R - 2, Memo)
              end,

            M3 =
              if
                L + 1 >= R - 1 ->
                  0;
                true ->
                  maxOperations_helper(Nums, L + 1, R - 1, Memo)
              end,

            Max1 =
              if
                L >= R ->
                  0;
                V1 == lists:nth(L + 1, Nums) + lists:nth(L + 2, Nums) ->
                  1 + M1;
                true ->
                  0
              end,

            Max2 =
              if
                L >= R ->
                  0;
                V2 == lists:nth(L + 1, Nums) + lists:nth(L + 2, Nums) ->
                  1 + M2;
                true ->
                  0
              end,

            Max3 =
              if
                L >= R ->
                  0;
                V3 == lists:nth(L + 1, Nums) + lists:nth(L + 2, Nums) ->
                  1 + M3;
                true ->
                  0
              end,

            Res0 =
              if
                L >= R ->
                  0;
                true ->
                  lists:max([Max1, Max2, Max3])
              end,

            Res0
        end,
      maps:put(L * 1000 + R, Res, Memo),
      Res;
    Res ->
      Res
  end.

memo_init(N, Memo) ->
  memo_init_helper(0, N * 1000 + N, #{}, Memo).

memo_init_helper(I, Max, Acc, Memo) ->
  if
    I >= Max ->
      Acc;
    true ->
      memo_init_helper(I + 1, Max, maps:put(I, {0, 0, 0}, Acc), Memo)
  end.