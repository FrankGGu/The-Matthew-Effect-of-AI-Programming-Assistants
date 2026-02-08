-module(min_steps).
-export([min_steps/2]).

min_steps(S, T) ->
  S_freq = string_to_freq(S),
  T_freq = string_to_freq(T),
  Diff = maps:difference(S_freq, T_freq),
  lists:sum([V || {_, V} <- maps:to_list(Diff)]).

string_to_freq(Str) ->
  string:foldl(
    fun(C, Acc) ->
      case maps:is_key(C, Acc) of
        true ->
          maps:update(C, maps:get(C, Acc) + 1, Acc);
        false ->
          maps:put(C, 1, Acc)
      end
    end,
    #{},
    Str
  ).