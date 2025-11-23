-module(min_flips_binary_grid_palindromic_ii).
-export([min_flips/1]).

min_flips(Grid) ->
  N = length(Grid),
  M = length(hd(Grid)),
  if N =/= M orelse N rem 2 =/= 0 ->
    -1;
  true ->
    solve(Grid)
  end.

solve(Grid) ->
  N = length(Grid),
  Visited = gb_sets:empty(),
  Q = queue:new(),
  queue:in({to_int(Grid), 0}, Q),
  solve_helper(N, Q, gb_sets:add(to_int(Grid), Visited)).

solve_helper(N, Q, Visited) ->
  case queue:out(Q) of
    {{value, {State, Steps}}, NewQ} ->
      if is_target(N, State) ->
        Steps;
      true ->
        Neighbors = get_neighbors(N, State),
        solve_helper(N, lists:foldl(fun({Neighbor, Cost}, AccQ) ->
                                        case gb_sets:is_element(Neighbor, Visited) of
                                          true -> AccQ;
                                          false ->
                                            queue:in({Neighbor, Steps + Cost}, AccQ)
                                        end
                                    end, NewQ, Neighbors),
                      lists:foldl(fun({Neighbor, _}, AccVisited) ->
                                      gb_sets:add(Neighbor, AccVisited)
                                  end, Visited, Neighbors))
      end;
    empty ->
      -1
  end.

get_neighbors(N, State) ->
  lists:flatten([
    [
      {flip_cells(N, State, I, J), 1}
     || J <- lists:seq(I + 1, N - 1)
    ]
   || I <- lists:seq(0, N - 1)
  ]).

flip_cells(N, State, I, J) ->
  Mask1 = 1 bsl (N - 1 - I),
  Mask2 = 1 bsl (N - 1 - J),
  State2 = bxor(bxor(State, Mask1), Mask2),
  State2.

is_target(N, State) ->
  State =:= 0.

to_int(Grid) ->
  lists:foldl(fun(Row, Acc) ->
                  lists:foldl(fun(Val, Acc2) ->
                                  (Acc2 bsl 1) bor Val
                              end, Acc, Row)
              end, 0, Grid).