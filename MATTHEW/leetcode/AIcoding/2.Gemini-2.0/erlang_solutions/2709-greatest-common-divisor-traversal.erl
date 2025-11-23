-module(gcd_traversal).
-export([greatest_common_divisor_traversal/1]).

greatest_common_divisor_traversal(Nums) ->
  N = length(Nums),
  Factors = [prime_factors(X) || X <- Nums],
  FactorMap = lists:foldl(fun(Fs, Acc) ->
                                  lists:foldl(fun(F, Acc2) ->
                                                    case maps:is_key(F, Acc2) of
                                                      true -> maps:update(F, maps:get(F, Acc2) ++ [Fs], Acc2);
                                                      false -> maps:put(F, [Fs], Acc2)
                                                    end
                                                end, Acc, Fs)
                              end, #{}, lists:zip(lists:seq(1, N), Factors)),
  UF = union_find:new(N),
  maps:map(fun(_, Group) ->
                    lists:foldl(fun(X, Acc) -> union_find:union(Acc, lists:nth(1, lists:nth(1, Group)), X) end, lists:nth(1, lists:nth(1, Group)), lists:delete(lists:nth(1, lists:nth(1, Group)), [X || {X, _} <- Group]))
           end, FactorMap),
  lists:all(fun(I) -> union_find:connected(UF, 1, I) end, lists:seq(2, N)).

prime_factors(N) ->
  prime_factors_helper(N, 2, []).

prime_factors_helper(1, _, Acc) ->
  lists:usort(Acc);
prime_factors_helper(N, F, Acc) when F * F > N ->
  lists:usort(Acc ++ [N]);
prime_factors_helper(N, F, Acc) when N rem F == 0 ->
  prime_factors_helper(N div F, F, Acc ++ [F]);
prime_factors_helper(N, F, Acc) ->
  prime_factors_helper(N, F + 1, Acc).

-module(union_find).
-export([new/1, find/2, union/3, connected/3]).

new(N) ->
  #{parent => lists:seq(1, N),
    size => lists:map(fun(_) -> 1 end, lists:seq(1, N))}.

find(UF, X) ->
  find_helper(UF, X).

find_helper(UF, X) ->
  Parent = maps:get(parent, UF),
  if lists:nth(X, Parent) == X ->
    X;
  true ->
    Root = find_helper(UF, lists:nth(X, Parent)),
    maps:put(parent, lists:update_at(X, Root, maps:get(parent, UF)), UF)
  end.

union(UF, X, Y) ->
  RootX = find(UF, X),
  RootY = find(UF, Y),
  if RootX == RootY ->
    UF;
  true ->
    Size = maps:get(size, UF),
    SizeX = lists:nth(RootX, Size),
    SizeY = lists:nth(RootY, Size),
    if SizeX < SizeY ->
      union_helper(UF, RootX, RootY);
    true ->
      union_helper(UF, RootY, RootX)
    end
  end.

union_helper(UF, X, Y) ->
  Parent = maps:get(parent, UF),
  Size = maps:get(size, UF),
  UpdatedParent = lists:update_at(X, Y, Parent),
  UpdatedSize = lists:update_at(Y, lists:nth(Y, Size) + lists:nth(X, Size), Size),
  maps:put(parent, UpdatedParent, maps:put(size, UpdatedSize, UF)).

connected(UF, X, Y) ->
  find(UF, X) == find(UF, Y).