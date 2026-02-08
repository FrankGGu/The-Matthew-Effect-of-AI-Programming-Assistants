-module(k_similar).
-export([kSimilarity/2]).

kSimilarity(S1, S2) ->
  kSimilarity_helper(string_to_list(S1), string_to_list(S2)).

kSimilarity_helper(S1, S2) ->
  Q = queue:new(),
  Vis = sets:new(),
  queue:in({S1, 0}, Q1) = Q,
  Vis1 = sets:add_element(S1, Vis),
  kSimilarity_bfs(Q1, S2, Vis1).

kSimilarity_bfs(Q, S2, Vis) ->
  case queue:is_empty(Q) of
    true ->
      infinity;
    false ->
      {value, {Curr, Steps}, Q1} = queue:out(Q),
      case Curr =:= S2 of
        true ->
          Steps;
        false ->
          Adj = get_neighbors(Curr, S2),
          {Q2, Vis2} = lists:foldl(fun(Next, {AccQ, AccVis}) ->
                                         case sets:is_element(Next, AccVis) of
                                           true ->
                                             {AccQ, AccVis};
                                           false ->
                                             queue:in({Next, Steps + 1}, AccQ1) = AccQ,
                                             {AccQ1, sets:add_element(Next, AccVis)}
                                         end
                                     end, {Q, Vis}, Adj),
          kSimilarity_bfs(Q2, S2, Vis2)
      end
  end.

get_neighbors(Curr, S2) ->
  I = find_first_diff(Curr, S2),
  get_neighbors_helper(Curr, S2, I, []).

get_neighbors_helper(Curr, S2, I, Acc) ->
  case I of
    -1 ->
      Acc;
    _ ->
      Char = lists:nth(I, S2),
      Indices = find_all_indices(Curr, Char, I + 1),
      NewNeighbors = lists:map(fun(J) ->
                                   swap(Curr, I, J)
                               end, Indices),
      get_neighbors_helper(Curr, S2, find_first_diff_from(Curr, S2, I + 1), Acc ++ NewNeighbors)
  end.

find_first_diff(S1, S2) ->
  find_first_diff_from(S1, S2, 0).

find_first_diff_from(S1, S2, Start) ->
  find_first_diff_helper(S1, S2, Start, length(S1)).

find_first_diff_helper(S1, S2, I, Len) ->
  case I >= Len of
    true ->
      -1;
    false ->
      case lists:nth(I, S1) =:= lists:nth(I, S2) of
        true ->
          find_first_diff_helper(S1, S2, I + 1, Len);
        false ->
          I
      end
  end.

find_all_indices(List, Element, Start) ->
  find_all_indices_helper(List, Element, Start, length(List), []).

find_all_indices_helper(List, Element, I, Len, Acc) ->
  case I >= Len of
    true ->
      Acc;
    false ->
      case lists:nth(I, List) =:= Element of
        true ->
          find_all_indices_helper(List, Element, I + 1, Len, [I | Acc]);
        false ->
          find_all_indices_helper(List, Element, I + 1, Len, Acc)
      end
  end.

swap(List, I, J) ->
  {A, [X | B]} = lists:split(I, List),
  {C, [Y | D]} = lists:split(J - I - 1, B),
  A ++ [Y] ++ C ++ [X] ++ D.

infinity() -> 16777215.