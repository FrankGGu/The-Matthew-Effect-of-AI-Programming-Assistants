-module(solution).
-export([count_pairs/2]).

count_pairs(N, Edges) ->
    Degree = maps:new(),
    EdgeCount = maps:new(),
    lists:foreach(fun([U, V]) ->
                      U1 = min(U, V),
                      V1 = max(U, V),
                      maps:update_with(U1, fun(Cnt) -> Cnt + 1 end, 1, EdgeCount),
                      maps:update_with(V1, fun(Cnt) -> Cnt + 1 end, 1, EdgeCount),
                      maps:update_with(U, fun(D) -> D + 1 end, 1, Degree),
                      maps:update_with(V, fun(D) -> D + 1 end, 1, Degree)
                  end, Edges),
    DegreeList = lists:sort(maps:values(Degree)),
    Len = length(DegreeList),
    Res = [],
    Q = length(Queries),
    lists:foreach(fun(Q) ->
                      QVal = lists:nth(Q, Queries),
                      Left = 1,
                      Right = Len,
                      Cnt = 0,
                      while (Left < Right) do
                          Sum = lists:nth(Left, DegreeList) + lists:nth(Right, DegreeList),
                          if Sum > QVal ->
                              Cnt = Cnt + (Right - Left),
                              Right = Right - 1;
                          true ->
                              Left = Left + 1
                          end
                      end,
                      Common = 0,
                      maps:foreach(fun({U, V}, C) ->
                                      Sum = maps:get(U, Degree) + maps:get(V, Degree),
                                      if Sum > QVal andalso Sum - C =< QVal ->
                                          Common = Common + 1;
                                      true ->
                                          ok
                                      end
                                  end, EdgeCount),
                      Res = Res ++ [Cnt - Common]
                  end, lists:seq(1, Q)),
    Res.