-module(min_deletions).
-export([min_deletions/1]).

min_deletions(S) ->
  Frequencies = lists:sort(lists:reverse, lists:foldl(fun(C, Acc) ->
                                                             case lists:keyfind(C, 1, Acc) of
                                                               false ->
                                                                 [{C, 1} | Acc];
                                                               {C, Count} ->
                                                                 lists:keyreplace(C, 1, Acc, {C, Count + 1})
                                                             end
                                                         end, [], string:to_list(S))),

  foldl(Frequencies, 0, []).

foldl([], Acc, _) ->
  Acc;
foldl([{_, Freq} | Rest], Acc, Seen) ->
  case lists:member(Freq, Seen) of
    true ->
      NewFreq = find_valid_freq(Freq, Seen),
      case NewFreq of
        -1 ->
          foldl(Rest, Acc + Freq, Seen);
        _ ->
          foldl(Rest, Acc + (Freq - NewFreq), [NewFreq | Seen])
      end;
    false ->
      foldl(Rest, Acc, [Freq | Seen])
  end.

find_valid_freq(Freq, Seen) ->
  case Freq of
    0 ->
      -1;
    _ ->
      if lists:member(Freq - 1, Seen) ->
        find_valid_freq(Freq - 1, Seen);
      true ->
        Freq - 1
      end
  end.