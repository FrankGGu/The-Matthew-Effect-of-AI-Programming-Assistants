-module(beauty_sum).
-export([beauty_sum/1]).

beauty_sum(S) ->
  beauty_sum(S, 0).

beauty_sum([], Acc) ->
  Acc;
beauty_sum([H|T], Acc) ->
  beauty_sum([H|T], Acc + beauty_sum_substrings([H|T])).

beauty_sum_substrings(S) ->
  beauty_sum_substrings(S, 0, length(S)).

beauty_sum_substrings(S, Start, Len) when Start >= Len ->
  0;
beauty_sum_substrings(S, Start, Len) ->
  Sub = lists:sublist(S, Start + 1, Len - Start),
  beauty_sum_substrings(S, Start + 1, Len) + beauty(Sub).

beauty(Sub) ->
  Counts = lists:foldl(fun(C, Acc) ->
    case maps:is_key(C, Acc) of
      true ->
        maps:update(C, maps:get(C, Acc) + 1, Acc);
      false ->
        maps:put(C, 1, Acc)
    end
  end, #{}, Sub),

  Values = maps:values(Counts),
  Max = lists:max(Values),
  Min = lists:min(Values),
  Max - Min.