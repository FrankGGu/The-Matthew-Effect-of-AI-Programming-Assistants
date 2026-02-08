-module(minimum_score_after_removals).
-export([minimum_score_after_removals/2]).

minimum_score_after_removals(Nums, Edges) ->
  N = length(Nums),
  Adj = create_adj_list(N, Edges),
  Xor_vals = calculate_xor_values(N, Nums, Adj),
  min_score_helper(N, Xor_vals, Edges).

create_adj_list(N, Edges) ->
  create_adj_list_helper(N, Edges, lists:seq(1, N), []).

create_adj_list_helper(N, [], Acc, Result) ->
  lists:zip(Acc, Result);
create_adj_list_helper(N, [{U, V} | Rest], Acc, Result) ->
  U_idx = U,
  V_idx = V,
  case lists:keyfind(U_idx, 1, Result) of
    false ->
      create_adj_list_helper(N, Rest, Acc, Result ++ [{U_idx, [V_idx]}]);
    {U_idx, Neighbors} ->
      create_adj_list_helper(N, Rest, Acc, lists:keyreplace(U_idx, 1, Result, {U_idx, Neighbors ++ [V_idx]}))
  end,
  case lists:keyfind(V_idx, 1, Result) of
    false ->
      create_adj_list_helper(N, Rest, Acc, Result ++ [{V_idx, [U_idx]}]);
    {V_idx, Neighbors} ->
      create_adj_list_helper(N, Rest, Acc, lists:keyreplace(V_idx, 1, Result, {V_idx, Neighbors ++ [U_idx]}))
  end.

calculate_xor_values(N, Nums, Adj) ->
  calculate_xor_values_helper(N, Nums, Adj, lists:seq(1, N), [], []).

calculate_xor_values_helper(N, Nums, Adj, [], Visited, Result) ->
  Result;
calculate_xor_values_helper(N, Nums, Adj, [Start | Rest], Visited, Result) ->
  {Xor_val, New_visited} = dfs_xor(Start, Nums, Adj, [], [Start], 0),
  calculate_xor_values_helper(N, Nums, Adj, Rest, New_visited ++ Visited, Result ++ [{Start, Xor_val}]).

dfs_xor(Node, Nums, Adj, Visited, Stack, Xor_val) ->
  Val = lists:nth(Node, Nums),
  New_xor_val = bxor(Xor_val, Val),
  case lists:keyfind(Node, 1, Adj) of
    {Node, Neighbors} ->
      {New_visited, New_stack, Final_xor} = dfs_xor_neighbors(Neighbors, Nums, Adj, Visited, Stack, New_xor_val),
      {New_visited, New_stack, Final_xor};
    false ->
      {Visited, Stack, New_xor_val}
  end.

dfs_xor_neighbors([], Nums, Adj, Visited, Stack, Xor_val) ->
  {Visited, Stack, Xor_val};
dfs_xor_neighbors([Neighbor | Rest], Nums, Adj, Visited, Stack, Xor_val) ->
  case lists:member(Neighbor, Stack) of
    true ->
      dfs_xor_neighbors(Rest, Nums, Adj, Visited, Stack, Xor_val);
    false ->
      {New_visited, New_stack, New_xor} = dfs_xor(Neighbor, Nums, Adj, Visited, Stack ++ [Neighbor], Xor_val),
      dfs_xor_neighbors(Rest, Nums, Adj, New_visited, New_stack, New_xor)
  end.

min_score_helper(N, Xor_vals, Edges) ->
  Full_xor = lists:foldl(fun({_, Xor}, Acc) -> bxor(Acc, Xor) end, 0, Xor_vals),
  min_score_helper_edges(Edges, Full_xor, Xor_vals, infinity).

min_score_helper_edges([], _, _, Min_score) ->
  Min_score;
min_score_helper_edges([{U1, V1} | Rest_edges], Full_xor, Xor_vals, Min_score) ->
  min_score_helper_edges_inner(Rest_edges, Full_xor, Xor_vals, U1, V1, Min_score).

min_score_helper_edges_inner([], _, _, _, _, Min_score) ->
  Min_score;
min_score_helper_edges_inner([{U2, V2} | Rest_edges], Full_xor, Xor_vals, U1, V1, Min_score) ->
  case connected(U1, V1, U2, V2, Xor_vals) of
    true ->
      {Xor1, Xor2} = find_xor_values(U1, V1, U2, V2, Xor_vals),
      Xor3 = bxor(bxor(Xor1, Xor2), Full_xor),
      Scores = [Xor1, Xor2, Xor3],
      Max_score = lists:max(Scores),
      Min_score_val = lists:min(Scores),
      Score = Max_score - Min_score_val,
      New_min_score = min(Min_score, Score),
      min_score_helper_edges_inner(Rest_edges, Full_xor, Xor_vals, U1, V1, New_min_score);
    false ->
      min_score_helper_edges_inner(Rest_edges, Full_xor, Xor_vals, U1, V1, Min_score)
  end.

find_xor_values(U1, V1, U2, V2, Xor_vals) ->
  Xor1 = get_xor_value(U1, V1, Xor_vals),
  Xor2 = get_xor_value(U2, V2, Xor_vals),
  {Xor1, Xor2}.

get_xor_value(U, V, Xor_vals) ->
  U_xor = lists:keyfind(U, 1, Xor_vals),
  V_xor = lists:keyfind(V, 1, Xor_vals),
  case {U_xor, V_xor} of
    {false, false} ->
      0;
    {false, {V, Val}} ->
      Val;
    {{U, Val}, false} ->
      Val;
    {{U, Val1}, {V, Val2}} ->
      case is_ancestor(U, V, Xor_vals) of
        true ->
          Val2;
        false ->
          Val1
      end
  end.

connected(U1, V1, U2, V2, Xor_vals) ->
  (is_ancestor(U1, V1, Xor_vals) andalso not is_ancestor(U1, U2, Xor_vals)) orelse
  (is_ancestor(U2, V2, Xor_vals) andalso not is_ancestor(U2, U1, Xor_vals)).

is_ancestor(Parent, Child, Xor_vals) ->
  Parent < Child.