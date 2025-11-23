-module(solution).
-export([wordSubsets/2]).

count_chars(Word) ->
    lists:foldl(fun(Char, Acc) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                end, #{}, Word).

get_max_b_counts(B_Words) ->
    lists:foldl(fun(B_Word, AccMaxCounts) ->
                    B_Counts = count_chars(B_Word),
                    maps:fold(fun(Char, Count, CurrentMax) ->
                                  maps:update_with(Char, fun(ExistingCount) -> max(ExistingCount, Count) end, Count, CurrentMax)
                              end, AccMaxCounts, B_Counts)
                end, #{}, B_Words).

is_universal(A_Counts, MaxB_Counts) ->
    lists:all(fun({Char, RequiredCount}) ->
                  case maps:find(Char, A_Counts) of
                      {ok, A_CharCount} -> A_CharCount >= RequiredCount;
                      _ -> false
                  end
              end, maps:to_list(MaxB_Counts)).

wordSubsets(A, B) ->
    MaxBCounts = get_max_b_counts(B),
    lists:filter(fun(A_Word) ->
                     A_Counts = count_chars(A_Word),
                     is_universal(A_Counts, MaxBCounts)
                 end, A).