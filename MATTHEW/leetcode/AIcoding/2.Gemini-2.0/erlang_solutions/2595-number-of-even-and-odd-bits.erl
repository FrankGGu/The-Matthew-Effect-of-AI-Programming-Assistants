-module(solution).
-export([even_odd_bits/1]).

even_odd_bits(N) ->
  even_odd_bits(N, 0, 0, 0).

even_odd_bits(0, Even, Odd, _) ->
  [Even, Odd];
even_odd_bits(N, Even, Odd, Pos) ->
  Bit = N band 1,
  case Pos rem 2 of
    0 ->
      case Bit of
        0 ->
          even_odd_bits(N bsr 1, Even, Odd, Pos + 1);
        1 ->
          even_odd_bits(N bsr 1, Even + 1, Odd, Pos + 1)
      end;
    1 ->
      case Bit of
        0 ->
          even_odd_bits(N bsr 1, Even, Odd, Pos + 1);
        1 ->
          even_odd_bits(N bsr 1, Even, Odd + 1, Pos + 1)
      end
  end.