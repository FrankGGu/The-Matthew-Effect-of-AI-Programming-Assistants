-module(number_complement).
-export([find_complement/1]).

find_complement(Num) ->
  Bits = integer_to_list(Num, 2),
  ComplementBits = [case Bit of
                        $0 -> $1;
                        $1 -> $0
                    end || Bit <- Bits],
  list_to_integer(ComplementBits, 2).