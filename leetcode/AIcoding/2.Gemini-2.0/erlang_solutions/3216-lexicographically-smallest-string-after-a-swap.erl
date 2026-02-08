-module(lexicographically_smallest_string_after_swap).
-export([smallestLexicalString/2]).

smallestLexicalString(S, Pairs) ->
  N = length(S),
  UF = uf_init(N),
  lists:foreach(fun({A, B}) -> uf_union(UF, A, B) end, Pairs),

  Components = lists:foldl(fun(I, Acc) ->
                                  Root = uf_find(UF, I),
                                  maps:update_with(Root, fun(L) -> [I | L] end, [I], Acc)
                              end, #{}, lists:seq(0, N - 1)),

  lists:foldl(fun({Root, Indices}, Acc) ->
                  Chars = lists:sort([lists:nth(I + 1, S) || I <- Indices]),
                  lists:foldl(fun(I, Acc2) ->
                                  lists:nth(I + 1, S, lists:nth(1, Chars)),
                                  lists:delete(lists:nth(1, Chars), Chars)
                              end, Acc, Indices)
              end, S, maps:to_list(Components)).

uf_init(N) -> lists:seq(0, N - 1).

uf_find(UF, I) -> uf_find_helper(UF, I, lists:nth(I + 1, UF)).

uf_find_helper(UF, I, Root) ->
  if I == Root ->
    Root;
  true ->
    NewRoot = uf_find_helper(UF, I, lists:nth(Root + 1, UF)),
    lists:nth(I + 1, UF, NewRoot),
    NewRoot
  end.

uf_union(UF, A, B) ->
  RootA = uf_find(UF, A),
  RootB = uf_find(UF, B),
  if RootA == RootB ->
    UF;
  true ->
    lists:nth(RootB + 1, UF, RootA),
    UF
  end.