-module(find_winner).
-export([find_the_winner/2]).

find_the_winner(Arr, K) ->
  find_winner_helper(Arr, K, hd(Arr), tl(Arr), 0).

find_winner_helper(_Arr, K, Winner, [], Count) ->
  case Count >= K of
    true -> Winner;
    false -> Winner
  end;
find_winner_helper(_Arr, K, Winner, [Next | Rest], Count) ->
  case Winner > Next of
    true ->
      case Count + 1 >= K of
        true -> Winner;
        false -> find_winner_helper(_Arr, K, Winner, Rest ++ [Next], Count + 1)
      end;
    false ->
      find_winner_helper(_Arr, K, Next, Rest ++ [Winner], 1)
  end.