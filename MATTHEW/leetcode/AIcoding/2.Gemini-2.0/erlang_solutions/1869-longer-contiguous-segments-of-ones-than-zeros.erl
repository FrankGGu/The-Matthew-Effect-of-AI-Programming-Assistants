-module(longer_contiguous_segments).
-export([longer_contiguous_segments/1]).

longer_contiguous_segments(S) ->
  longer_contiguous_segments(S, 0, 0, 0, 0).

longer_contiguous_segments([], Ones, Zeros, _, _) ->
  Ones > Zeros;
longer_contiguous_segments([$0 | T], Ones, Zeros, CurrentOnes, CurrentZeros) ->
  longer_contiguous_segments(T, Ones, max(Zeros, CurrentOnes), CurrentOnes, CurrentZeros + 1);
longer_contiguous_segments([$1 | T], Ones, Zeros, CurrentOnes, CurrentZeros) ->
  longer_contiguous_segments(T, max(Ones, CurrentZeros), Zeros, CurrentOnes + 1, CurrentZeros).