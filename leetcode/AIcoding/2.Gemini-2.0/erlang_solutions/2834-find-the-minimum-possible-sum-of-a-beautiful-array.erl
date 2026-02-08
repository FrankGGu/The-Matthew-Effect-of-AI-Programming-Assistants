-module(minimum_beautiful_sum).
-export([minimum_possible_sum/2]).

minimum_possible_sum(N, MaxSum) ->
  minimum_possible_sum(N, MaxSum, 1, []).

minimum_possible_sum(0, _, _, Acc) ->
  lists:sum(Acc);
minimum_possible_sum(N, MaxSum, Start, Acc) ->
  case lists:member(Start, Acc) of
    true ->
      minimum_possible_sum(N, MaxSum, Start + 1, Acc);
    false ->
      Sum = Start + lists:sum(Acc);
      case Sum > MaxSum of
        true ->
          minimum_possible_sum(N, MaxSum, Start + 1, Acc);
        false ->
          Conflicts = [X || X <- Acc, Start + X =:= 2 * Start],
          case Conflicts of
            [] ->
              minimum_possible_sum(N - 1, MaxSum, Start + 1, [Start | Acc]);
            _ ->
              minimum_possible_sum(N, MaxSum, Start + 1, Acc)
          end
      end
  end.