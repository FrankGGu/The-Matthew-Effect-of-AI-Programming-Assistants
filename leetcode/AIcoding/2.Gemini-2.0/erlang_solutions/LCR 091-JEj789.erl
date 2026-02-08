-module(paint_house).
-export([min_cost/1]).

min_cost(Costs) ->
  case Costs of
    [] -> 0;
    _ ->
      {R, G, B} = lists:foldl(
        fun(C, {PrevR, PrevG, PrevB}) ->
          [CostR, CostG, CostB] = C,
          NewR = CostR + min(PrevG, PrevB),
          NewG = CostG + min(PrevR, PrevB),
          NewB = CostB + min(PrevR, PrevG),
          {NewR, NewG, NewB}
        end,
        {0, 0, 0},
        Costs
      ),
      min(min(R, G), B)
  end.