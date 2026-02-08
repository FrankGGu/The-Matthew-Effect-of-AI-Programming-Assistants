-module(minimize_deviation).
-export([minimumDeviation/1]).

minimumDeviation(Nums) ->
  Set = gb_sets:from_list(lists:sort(lists:flatmap(fun(X) ->
                                                      case X rem 2 of
                                                        0 -> [X, X div 2];
                                                        1 -> [X, X * 2]
                                                      end
                                                    end, Nums))),
  minimumDeviationHelper(Set).

minimumDeviationHelper(Set) ->
  {Min, Set1} = gb_sets:take_smallest(Set),
  {Max, _} = gb_sets:take_greatest(Set1),
  Deviation = Max - Min,

  case Min rem 2 of
    0 ->
      NewSet = gb_sets:add(Min div 2, gb_sets:delete(Min, Set1)),
      NewDeviation = minimumDeviationHelper(NewSet),
      min(Deviation, NewDeviation);
    1 ->
      Deviation
  end.