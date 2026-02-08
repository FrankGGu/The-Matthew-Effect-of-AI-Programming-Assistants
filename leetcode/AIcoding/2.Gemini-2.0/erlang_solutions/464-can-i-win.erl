-module(can_i_win).
-export([can_i_win/2]).

can_i_win(MaxChoosableInteger, DesiredTotal) ->
  if DesiredTotal =< 0 ->
    true;
  MaxChoosableInteger * (MaxChoosableInteger + 1) div 2 < DesiredTotal ->
    false;
  true ->
    can_win(MaxChoosableInteger, DesiredTotal, sets:from_list([])).

can_win(MaxChoosableInteger, DesiredTotal, Used) ->
  if DesiredTotal =< 0 ->
    false;
  true ->
    lists:any(fun(X) ->
                  sets:is_element(X, Used) == false andalso
                    (DesiredTotal - X =< 0 orelse
                       not can_win(MaxChoosableInteger, DesiredTotal - X, sets:add_element(X, Used)))
              end, lists:seq(1, MaxChoosableInteger)).