-module(word_pattern).
-export([word_pattern/2]).

word_pattern(Pattern, S) ->
  Words = string:split(S, " ", all),
  PL = string:to_list(Pattern),
  length(PL) == length(Words) andalso check_pattern(PL, Words).

check_pattern(PL, Words) ->
  Map = dict:new(),
  RMap = dict:new(),
  check_pattern_helper(PL, Words, Map, RMap).

check_pattern_helper([], [], Map, RMap) ->
  true;
check_pattern_helper([P | PT], [W | WT], Map, RMap) ->
  case dict:find(P, Map) of
    {ok, Val} ->
      Val == W andalso
        case dict:find(W, RMap) of
          {ok, Key} ->
            Key == P andalso check_pattern_helper(PT, WT, Map, RMap);
          error ->
            false
        end;
    error ->
      case dict:find(W, RMap) of
        {ok, _} ->
          false;
        error ->
          NewMap = dict:store(P, W, Map),
          NewRMap = dict:store(W, P, RMap),
          check_pattern_helper(PT, WT, NewMap, NewRMap)
      end
  end.