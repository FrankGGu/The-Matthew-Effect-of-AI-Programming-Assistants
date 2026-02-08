-module(maximum_xor).
-export([maximize_xor/2]).

maximize_xor(Nums, Queries) ->
  MaxBit := 1,
  lists:foreach(fun(N) ->
                    MaxBit1 := integer_to_list(N, 2),
                    MaxBit2 := length(MaxBit1),
                    MaxBit := max(MaxBit, MaxBit2)
                end, Nums),
  MaxNum := (1 bsl MaxBit) - 1,
  maximize_xor(Nums, Queries, MaxNum, []).

maximize_xor([], [], _, Acc) ->
  lists:reverse(Acc);
maximize_xor(Nums, [Query | RestQueries], MaxNum, Acc) ->
  XorVal := MaxNum - Query,
  MinDiff := lists:foldl(fun(Num, Acc1) ->
                              min(Acc1, abs(Num bxor Query))
                          end, MaxNum + 1, Nums),
  Result := lists:foldl(fun(Num, Acc1) ->
                             if Num bxor Query == MinDiff ->
                                 Num bxor Query;
                             true ->
                                 Acc1
                             end
                         end, 0, Nums),
  maximize_xor(Nums, RestQueries, MaxNum, [MaxNum - MinDiff|Acc]).