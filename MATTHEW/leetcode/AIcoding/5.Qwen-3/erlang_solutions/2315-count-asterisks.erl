-module(count_asterisks).
-export([countAsterisks/1]).

countAsterisks(S) ->
    countAsterisks(S, 0, false).

countAsterisks([], Count, _) ->
    Count;
countAsterisks([$\* | T], Count, true) ->
    countAsterisks(T, Count + 1, true);
countAsterisks([$\* | T], Count, false) ->
    countAsterisks(T, Count + 1, false);
countAsterisks([$\| | T], Count, true) ->
    countAsterisks(T, Count, false);
countAsterisks([$\| | T], Count, false) ->
    countAsterisks(T, Count, true);
countAsterisks([_ | T], Count, In) ->
    countAsterisks(T, Count, In).