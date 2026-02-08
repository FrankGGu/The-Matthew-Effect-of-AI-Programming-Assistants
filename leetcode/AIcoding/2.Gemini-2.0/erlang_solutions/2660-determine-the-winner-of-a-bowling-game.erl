-module(bowling_winner).
-export([is_winner/2]).

is_winner(Player1, Player2) ->
  Score1 = calculate_score(Player1),
  Score2 = calculate_score(Player2),
  case Score1 > Score2 of
    true -> 1;
    false ->
      case Score2 > Score1 of
        true -> 2;
        false -> 0
      end
  end.

calculate_score(Player) ->
  calculate_score(Player, 0, 0).

calculate_score([], Acc, Bonus) ->
  Acc + Bonus;
calculate_score([H | T], Acc, Bonus) ->
  case Bonus > 0 of
    true ->
      NewAcc = Acc + 2 * H,
      NewBonus = Bonus - 1,
      calculate_score(T, NewAcc, NewBonus);
    false ->
      NewAcc = Acc + H,
      NewBonus =
        case H =:= 10 of
          true -> 2;
          false -> 0
        end,
      calculate_score(T, NewAcc, NewBonus)
  end.