-module(three_divisors).
-export([three_divisors/1]).

three_divisors(N) ->
  Is_Prime = fun(Num) ->
    case Num < 2 of
      true -> false;
      false ->
        case lists:all(fun(I) -> Num rem I /= 0 end, lists:seq(2, trunc(math:sqrt(Num)))) of
          true -> true;
          false -> false
        end
    end
  end,

  S = trunc(math:sqrt(N)),
  Is_Prime(S) andalso S * S == N.