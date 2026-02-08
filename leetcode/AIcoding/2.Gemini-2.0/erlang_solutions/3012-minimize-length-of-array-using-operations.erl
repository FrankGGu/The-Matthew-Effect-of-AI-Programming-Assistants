-module(minimize_length).
-export([min_length/1]).

min_length(Nums) ->
  min_length_helper(Nums, []).

min_length_helper([], Acc) ->
  length(Acc);
min_length_helper(Nums, Acc) ->
  {Counts, _} = lists:foldl(fun(X, {CountsAcc, Seen}) ->
                                  case lists:member(X, Seen) of
                                    true ->
                                      {CountsAcc, Seen};
                                    false ->
                                      {[{X, lists:sum([1 || Y <- Nums, Y == X])}|CountsAcc], [X|Seen]}
                                  end
                              end, {[], []}, Nums),

  MaxValue = lists:max([V || {_, V} <- Counts]),

  case MaxValue > length(Nums) - MaxValue of
    true ->
      1;
    false ->
      case length(Nums) rem 2 == 0 of
        true -> 0;
        false -> 1
      end
  end.