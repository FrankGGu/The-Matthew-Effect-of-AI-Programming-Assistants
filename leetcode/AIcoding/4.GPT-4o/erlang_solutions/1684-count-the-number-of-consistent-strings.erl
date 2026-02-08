-module(solution).
-export([count_consistent_strings/2]).

count_consistent_strings(allowed, words) ->
    AllowedSet = sets:from_list(string:to_lower(allowed)),
    lists:foldl(fun(Word, Acc) ->
                      if
                          sets:is_subset(string:to_lower(Word), AllowedSet) -> 
                              Acc + 1;
                          true -> 
                              Acc
                      end
                  end, 0, words).