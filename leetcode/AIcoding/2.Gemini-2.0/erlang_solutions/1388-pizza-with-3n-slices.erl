-module(pizza_with_3n_slices).
-export([max_size_slices/1]).

max_size_slices(Slices) ->
  n = length(Slices) div 3,
  max_size_slices_helper(Slices, n).

max_size_slices_helper(Slices, N) ->
  case N of
    0 -> 0;
    _ ->
      {Included, Excluded} = knapsack(Slices, N),
      max(Included, Excluded)
  end.

knapsack(Slices, N) ->
  {Incl, Excl} = knapsack_helper(Slices, N, []),
  {Incl, Excl}.

knapsack_helper(Slices, N, Acc) ->
  Len = length(Slices),
  case Len of
    0 -> {0, 0};
    1 ->
      case N of
        0 -> {0, 0};
        1 -> {hd(Slices), 0};
        _ -> {0, 0}
      end;
    _ ->
      case N of
        0 -> {0, 0};
        _ ->
          First = hd(Slices),
          Rest = tl(Slices),
          {Incl1, Excl1} = case N - 1 of
            Neg when Neg < 0 -> {0,0};
            NN ->
              case Len - 1 of
                1 -> {First,0};
                _ ->
                  {InclRest, ExclRest} = knapsack_helper(lists:sublist(Rest,1,Len-2),NN, Acc),
                  {InclRest + First, ExclRest + First}
              end
          end,

          {Incl2, Excl2} = knapsack_helper(Rest, N, Acc),
          {max(Incl1,Excl1), max(Incl2, Excl2)}
      end
  end.