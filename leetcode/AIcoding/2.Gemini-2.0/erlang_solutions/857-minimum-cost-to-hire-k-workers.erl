-module(minimum_cost_to_hire_k_workers).
-export([min_cost_to_hire_workers/3]).

min_cost_to_hire_workers(Quality, Wage, K) ->
  Workers = lists:zip(Quality, Wage),
  Ratios = [WageI / QualityI || {QualityI, WageI} <- Workers],
  SortedRatios = lists:sort(Ratios),
  min_cost(Workers, SortedRatios, K, infinity).

min_cost(Workers, [Ratio | Rest], K, MinCost) ->
  Qualities = [Quality || {Quality, Wage} <- Workers, Wage / Quality =< Ratio],
  if length(Qualities) < K ->
    min_cost(Workers, Rest, K, MinCost);
  true ->
    SortedQualities = lists:sort(Qualities, fun(A, B) -> A > B end),
    SelectedQualities = lists:sublist(SortedQualities, 1, K),
    Cost = Ratio * lists:sum(SelectedQualities),
    NewMinCost = min(MinCost, Cost),
    case Rest of
      [] ->
        NewMinCost;
      _ ->
        min_cost(Workers, Rest, K, NewMinCost)
    end
  end.

min_cost(_, [], _, MinCost) ->
  MinCost.

min(A, B) ->
  if A < B -> A; true -> B end.

infinity() ->
  1.0e30.