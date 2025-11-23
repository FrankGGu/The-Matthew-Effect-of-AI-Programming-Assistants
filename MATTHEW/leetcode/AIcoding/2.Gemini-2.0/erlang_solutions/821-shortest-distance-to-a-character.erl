-module(shortest_distance).
-export([shortestToChar/2]).

shortestToChar(S, C) ->
  shortestToChar(S, C, []).

shortestToChar(S, C, Acc) ->
  Len = length(S),
  Chars = string:to_list(S),
  shortestToChar(Chars, C, 0, Len - 1, Acc, []).

shortestToChar([], _, _, _, Acc, Res) ->
  lists:reverse(Res);
shortestToChar([H|T], C, I, End, Acc, Res) ->
  MinDist = findMinDist(string:to_list(S), C, I, End),
  shortestToChar(T, C, I + 1, End, Acc, [MinDist|Res]).

findMinDist(S, C, I, End) ->
  findMinDist(S, C, I, End, 100000).

findMinDist(S, C, I, End, MinDist) ->
  findMinDist(S, C, I, 0, End, MinDist).

findMinDist(S, C, I, J, End, MinDist) ->
  case J > End of
    true -> MinDist;
    false ->
      Char = lists:nth(J + 1, S),
      case Char =:= C of
        true ->
          Dist = abs(J - I),
          NewMinDist = min(MinDist, Dist),
          NewMinDist;
        false ->
          findMinDist(S, C, I, J + 1, End, MinDist)
      end
  end.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

shortestToChar_test() ->
  ?assertEqual([3,2,1,0,1,0,0,1,2,2,1,0], shortest_distance:shortestToChar("loveleetcode", $e)),
  ?assertEqual([3,2,1,0], shortest_distance:shortestToChar("aaba", $b)).

-endif.