-module(most_frequent_even).
-export([most_frequent_even/1]).

most_frequent_even(Nums) ->
  EvenNums = [N || N <- Nums, N rem 2 == 0],
  case EvenNums of
    [] ->
      -1;
    _ ->
      Frequencies = lists:foldl(fun(N, Acc) ->
                                    maps:update_with(N, fun(Count) -> Count + 1 end, 1, Acc)
                                end, #{}, EvenNums),
      lists:foldl(fun({Num, Count}, {BestNum, BestCount}) ->
                      case Count > BestCount orelse (Count == BestCount andalso Num < BestNum) of
                        true -> {Num, Count};
                        false -> {BestNum, BestCount}
                      end
                  end, {hd(EvenNums), 0}, maps:to_list(Frequencies))
        end.

most_frequent_even(Nums) ->
    EvenNums = [N || N <- Nums, N rem 2 == 0],
    case EvenNums of
        [] -> -1;
        _ ->
            Frequencies = lists:foldl(fun(N, Acc) ->
                maps:update_with(N, fun(Count) -> Count + 1 end, 1, Acc)
            end, #{}, EvenNums),
            lists:foldl(fun({Num, Count}, {BestNum, BestCount}) ->
                case Count > BestCount orelse (Count == BestCount and Num < BestNum) of
                    true -> {Num, Count};
                    false -> {BestNum, BestCount}
                end
            end, {lists:nth(1, lists:sort(EvenNums)), 0}, maps:to_list(Frequencies))
    end.