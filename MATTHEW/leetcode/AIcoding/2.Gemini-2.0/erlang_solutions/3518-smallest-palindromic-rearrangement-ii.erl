-module(smallest_palindromic_rearrangement2).
-export([smallest_palindrome/1]).

smallest_palindrome(S) ->
    Counts = lists:foldl(fun(C, Acc) ->
                                 maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, S),
    OddChars = [C || {C, Count} <- maps:to_list(Counts), Count rem 2 =/= 0],
    case length(OddChars) > 1 of
        true -> "" ;
        false ->
            SortedChars = lists:sort(S),
            {Left, Middle} = lists:foldl(fun(C, {L, M}) ->
                                                 Count = maps:get(C, Counts),
                                                 case Count rem 2 =/= 0 of
                                                     true -> {L, [C | M]} ;
                                                     false ->
                                                         HalfCount = Count div 2,
                                                         {L ++ lists:duplicate(HalfCount, [C]), M}
                                                 end
                                         end, {[], []}, SortedChars),
            lists:flatten(lists:reverse(Left) ++ Middle ++ Left)
    end.