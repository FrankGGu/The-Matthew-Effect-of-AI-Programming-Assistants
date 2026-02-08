-module(close_strings).
-export([close_strings/2]).

close_strings(Word1, Word2) ->
  Map1 = build_frequency_map(Word1),
  Map2 = build_frequency_map(Word2),

  Keys1 = maps:keys(Map1),
  Keys2 = maps:keys(Map2),

  case lists:sort(Keys1) =:= lists:sort(Keys2) of
    true ->
      Values1 = lists:sort(maps:values(Map1)),
      Values2 = lists:sort(maps:values(Map2)),
      Values1 =:= Values2;
    false ->
      false
  end.

build_frequency_map(Word) ->
  build_frequency_map(Word, #{}).

build_frequency_map([], Map) ->
  Map;
build_frequency_map([Char | Rest], Map) ->
  case maps:is_key(Char, Map) of
    true ->
      build_frequency_map(Rest, maps:update(Char, maps:get(Char, Map) + 1, Map));
    false ->
      build_frequency_map(Rest, maps:put(Char, 1, Map))
  end.