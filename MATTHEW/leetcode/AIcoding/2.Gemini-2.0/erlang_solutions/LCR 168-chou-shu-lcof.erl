-module(ugly_number).
-export([is_ugly/1]).

is_ugly(N) ->
  is_ugly(N, [2, 3, 5]).

is_ugly(N, []) ->
  N == 1;
is_ugly(N, [Factor | Rest]) ->
  case N rem Factor of
    0 ->
      is_ugly(N div Factor, [Factor | Rest]);
    _ ->
      is_ugly(N, Rest)
  end.