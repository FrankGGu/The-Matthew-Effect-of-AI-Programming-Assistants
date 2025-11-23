-module(rearrange_characters).
-export([rearrangeCharacters/2]).

rearrangeCharacters(S, Target) ->
  S_counts = string_to_counts(S),
  Target_counts = string_to_counts(Target),
  min_rearrangements(S_counts, Target_counts).

string_to_counts(String) ->
  string:foldl(
    fun(Char, Acc) ->
      case maps:is_key(Char, Acc) of
        true ->
          maps:update(Char, maps:get(Char, Acc) + 1, Acc);
        false ->
          maps:put(Char, 1, Acc)
      end
    end,
    #{},
    String
  ).

min_rearrangements(S_counts, Target_counts) ->
  Counts = maps:fold(
    fun(Char, Target_count, Acc) ->
      case maps:is_key(Char, S_counts) of
        true ->
          S_count = maps:get(Char, S_counts);
          Count = S_count div Target_count;
          [Count | Acc];
        false ->
          [0 | Acc]
      end
    end,
    [],
    Target_counts
  ),
  lists:min(Counts).