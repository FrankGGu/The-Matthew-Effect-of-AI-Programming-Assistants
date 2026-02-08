-module(squareful_arrays).
-export([numSquarefulPerms/1]).

numSquarefulPerms(A) ->
  Len = length(A),
  UniqueA = lists:usort(A),
  CountMap = lists:foldl(fun(X, Acc) ->
                                  maps:update_with(X, fun(Y) -> Y + 1 end, 1, Acc)
                          end, #{}, A),
  Adj = make_adj(UniqueA),
  Count = maps:from_list([{K, maps:get(K, CountMap)} || K <- UniqueA]),
  dfs(UniqueA, Adj, Count, Len, 0).

make_adj(UniqueA) ->
  lists:foldl(fun(X, Acc) ->
                  Neighbors = [Y || Y <- UniqueA, is_square(X + Y)],
                  maps:put(X, Neighbors, Acc)
              end, #{}, UniqueA).

is_square(N) ->
  S = floor(math:sqrt(N)),
  S * S =:= N.

dfs(_, _, Count, 0, Acc) ->
  Acc;
dfs(UniqueA, Adj, Count, Remaining, Acc) ->
  lists:foldl(fun(Start, Acc1) ->
                  Num = maps:get(Start, Count, 0),
                  if
                    Num > 0 ->
                      NewCount = maps:update_with(Start, fun(X) -> X - 1 end, 0, Count),
                      Neighbors = maps:get(Start, Adj),
                      dfs(UniqueA, Adj, NewCount, Remaining - 1, Acc1);
                    true ->
                      Acc1
                  end
              end, Acc, UniqueA).