-module(small_even_multiple).
-export([smallest_even_multiple/1]).

smallest_even_multiple(N) ->
    case N rem 2 of
        0 -> N;
        _ -> N * 2
    end.