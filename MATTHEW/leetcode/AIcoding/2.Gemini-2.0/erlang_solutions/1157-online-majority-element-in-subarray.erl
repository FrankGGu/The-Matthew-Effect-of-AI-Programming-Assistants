-module(majority_element).
-export([new/1, query/3]).

new(Arr) ->
  {dict:from_list(lists:zip(lists:seq(1, length(Arr)), Arr)), Arr}.

query({Dict, Arr}, Left, Right, Threshold) ->
  query_helper(Dict, Arr, Left, Right, Threshold).

query_helper(Dict, Arr, Left, Right, Threshold) ->
  Len = Right - Left + 1,
  if
    Len < Threshold ->
      -1;
    true ->
      Candidate = dict:fetch(Left, Dict),
      Count = count_occurrences(Arr, Candidate, Left, Right),
      if
        Count >= Threshold ->
          Candidate;
        true ->
          Candidate2 = dict:fetch(Left + (Len div 2), Dict),
          Count2 = count_occurrences(Arr, Candidate2, Left, Right),
          if
            Count2 >= Threshold ->
              Candidate2;
            true ->
              Candidate3 = dict:fetch(Right, Dict),
              Count3 = count_occurrences(Arr, Candidate3, Left, Right),
              if
                Count3 >= Threshold ->
                  Candidate3;
                true ->
                  -1
              end
          end
      end
  end.

count_occurrences(Arr, Candidate, Left, Right) ->
  count_occurrences_helper(Arr, Candidate, Left, Right, 0).

count_occurrences_helper(Arr, Candidate, Left, Right, Acc) ->
  if
    Left > Right ->
      Acc;
    true ->
      if
        lists:nth(Left, Arr) == Candidate ->
          count_occurrences_helper(Arr, Candidate, Left + 1, Right, Acc + 1);
        true ->
          count_occurrences_helper(Arr, Candidate, Left + 1, Right, Acc)
      end
  end.