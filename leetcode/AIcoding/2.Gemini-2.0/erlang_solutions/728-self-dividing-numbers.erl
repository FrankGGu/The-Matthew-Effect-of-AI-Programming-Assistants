-module(self_dividing_numbers).
-export([self_dividing_numbers/2]).

self_dividing_numbers(Left, Right) ->
  lists:filter(fun is_self_dividing/1, lists:seq(Left, Right)).

is_self_dividing(N) ->
  is_self_dividing(N, N).

is_self_dividing(N, Original) ->
  case N of
    0 -> false;
    _ ->
      Digit = N rem 10,
      case Digit of
        0 -> false;
        _ ->
          case (Original rem Digit) == 0 of
            true ->
              case N div 10 of
                0 -> true;
                _ -> is_self_dividing(N div 10, Original)
              end;
            false -> false
          end
      end
  end.