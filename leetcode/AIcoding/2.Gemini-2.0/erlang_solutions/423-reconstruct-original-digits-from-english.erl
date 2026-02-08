-module(reconstruct_digits).
-export([original_digits/1]).

original_digits(S) ->
  Counts = string_to_counts(S),
  Digits = counts_to_digits(Counts),
  lists:sort(Digits).

string_to_counts(S) ->
  string_to_counts(S, []).

string_to_counts([], Acc) ->
  Acc;
string_to_counts([H|T], Acc) ->
  string_to_counts(T, update_count(H, Acc)).

update_count(Char, Acc) ->
  case lists:keyfind(Char, 1, Acc) of
    false ->
      [{Char, 1} | Acc];
    {Char, Count} ->
      lists:keyreplace(Char, 1, Acc, {Char, Count + 1})
  end.

counts_to_digits(Counts) ->
  Zero = get_count($z, Counts),
  Two = get_count($w, Counts),
  Four = get_count($u, Counts),
  Six = get_count($x, Counts),
  Eight = get_count($g, Counts),

  Three = get_count($h, Counts) - Eight,
  Five = get_count($f, Counts) - Four,
  Seven = get_count($v, Counts) - Five,

  One = get_count($o, Counts) - Zero - Two - Four,
  Nine = get_count($i, Counts) - Five - Six - Eight,

  lists:flatten(
    [
      lists:duplicate(Zero, 0),
      lists:duplicate(One, 1),
      lists:duplicate(Two, 2),
      lists:duplicate(Three, 3),
      lists:duplicate(Four, 4),
      lists:duplicate(Five, 5),
      lists:duplicate(Six, 6),
      lists:duplicate(Seven, 7),
      lists:duplicate(Eight, 8),
      lists:duplicate(Nine, 9)
    ]
  ).

get_count(Char, Counts) ->
  case lists:keyfind(Char, 1, Counts) of
    false ->
      0;
    {_, Count} ->
      Count
  end.