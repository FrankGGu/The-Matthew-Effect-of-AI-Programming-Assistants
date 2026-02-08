-module(solution).
-export([get_winner/2]).

get_winner(N, K) when K >= N div 2 + 1 -> 
    lists:max([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]).

get_winner(N, K) -> 
    Winner = fun(Prev, Cur, Wins, K) ->
        case Wins of
            K -> Cur;
            _ -> case Cur > Prev of
                    true -> Winner(Cur, Prev, Wins + 1, K);
                    false -> Winner(Prev, Cur, 1, K)
                  end
        end
    end,
    Winner(1, 2, 0, K).