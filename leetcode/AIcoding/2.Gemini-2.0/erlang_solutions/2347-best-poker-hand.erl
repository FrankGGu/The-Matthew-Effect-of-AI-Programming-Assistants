-module(best_poker_hand).
-export([best_hand/2]).

best_hand(ranks, suits) ->
  case is_flush(suits) of
    true -> "Flush";
    false ->
      RankCounts = lists:foldl(fun(R, Acc) ->
                                    maps:update_with(R, fun(C) -> C + 1 end, 1, Acc)
                                end, #{}, ranks),
      MaxCount = lists:max(maps:values(RankCounts)),
      case MaxCount of
        5 -> "Three of a Kind";
        4 -> "Pair";
        3 -> "Three of a Kind";
        2 -> "Pair";
        1 -> "High Card"
      end
  end.

is_flush(Suits) ->
  lists:all(fun(Suit) -> Suit =:= lists:nth(1, Suits) end, Suits).