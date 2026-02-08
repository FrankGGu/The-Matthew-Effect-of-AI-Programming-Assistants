-module(max_diff_even_odd_freq_1).
-export([maximum_difference/1]).

maximum_difference(Nums) ->
  Frequencies = lists:foldl(fun(Num, Acc) ->
                                  case lists:keyfind(Num, 1, Acc) of
                                    false ->
                                      [{Num, 1} | Acc];
                                    {Num, Freq} ->
                                      lists:keyreplace(Num, 1, Acc, {Num, Freq + 1})
                                  end
                              end, [], Nums),
  EvenFreqs = [Num || {Num, Freq} <- Frequencies, Freq rem 2 =:= 0],
  OddFreqs = [Num || {Num, Freq} <- Frequencies, Freq rem 2 =:= 1],

  case {EvenFreqs, OddFreqs} of
    {[], []} ->
      -1;
    {[], _} ->
      lists:max(OddFreqs);
    {_, []} ->
      lists:max(EvenFreqs);
    _ ->
      lists:max(EvenFreqs) - lists:max(OddFreqs)
  end.