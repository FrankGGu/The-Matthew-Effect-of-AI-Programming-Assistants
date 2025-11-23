-module(min_window_substring).
-export([min_window/2]).

min_window(S, T) ->
  min_window(string:to_list(S), string:to_list(T)).

min_window(S, T) ->
  LenS = length(S),
  LenT = length(T),
  if LenS < LenT ->
    ""
  else
    TCount = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, #{}, T),
    min_window_helper(S, TCount, 0, LenS - 1, infinity, "", #{}, 0, 0)
  end.

min_window_helper(S, TCount, Start, End, MinLen, MinWindow, WindowCount, Left, Right) ->
  case Right > End of
    true ->
      MinWindow;
    false ->
      Char = lists:nth(Right + 1, S),
      NewWindowCount = maps:update_with(Char, fun(X) -> X + 1 end, 1, WindowCount),
      case maps:is_key(Char, TCount) of
        true ->
          case maps:get(Char, NewWindowCount, 0) =< maps:get(Char, TCount, 0) of
            true ->
              case check_window(TCount, NewWindowCount) of
                true ->
                  trim_window(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, Left, Right);
                false ->
                  min_window_helper(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, Left, Right + 1)
              end;
            false ->
              min_window_helper(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, Left, Right + 1)
          end;
        false ->
          min_window_helper(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, Left, Right + 1)
      end
  end.

trim_window(S, TCount, Start, End, MinLen, MinWindow, WindowCount, Left, Right) ->
  case Left > Right of
    true ->
      {MinLen, MinWindow};
    false ->
      Char = lists:nth(Left + 1, S),
      case maps:is_key(Char, TCount) of
        true ->
          case maps:get(Char, WindowCount, 0) > maps:get(Char, TCount, 0) of
            true ->
              NewWindowCount = maps:update_with(Char, fun(X) -> X - 1 end, 0, WindowCount),
              NewLeft = Left + 1,
              NewLen = Right - NewLeft + 1,
              case NewLen < MinLen of
                true ->
                  NewMinWindow = lists:sublist(S, NewLeft + 1, NewLen),
                  trim_window(S, TCount, Start, End, NewLen, NewMinWindow, NewWindowCount, NewLeft, Right);
                false ->
                  trim_window(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, NewLeft, Right)
              end;
            false ->
              NewLen = Right - Left + 1,
              case NewLen < MinLen of
                true ->
                  NewMinWindow = lists:sublist(S, Left + 1, NewLen),
                  list_to_string(NewMinWindow);
                false ->
                  list_to_string(MinWindow)
              end
          end;
        false ->
          NewWindowCount = maps:update_with(Char, fun(X) -> X - 1 end, 0, WindowCount),
          NewLeft = Left + 1,
          NewLen = Right - NewLeft + 1,
          case NewLen < MinLen of
            true ->
              NewMinWindow = lists:sublist(S, NewLeft + 1, NewLen),
              trim_window(S, TCount, Start, End, NewLen, NewMinWindow, NewWindowCount, NewLeft, Right);
            false ->
              trim_window(S, TCount, Start, End, MinLen, MinWindow, NewWindowCount, NewLeft, Right)
          end
      end
  end.

check_window(TCount, WindowCount) ->
  maps:all(fun(K, V) -> maps:get(K, WindowCount, 0) >= V end, TCount).

list_to_string(List) ->
  list_to_binary(List).