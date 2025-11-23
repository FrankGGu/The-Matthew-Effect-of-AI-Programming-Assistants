-module(solution).
-export([longest_palindrome/1]).

-spec longest_palindrome(unicode:unicode_binary()) -> integer().
longest_palindrome(S) ->
    CharCounts = count_chars(S),
    {EvenCount, OddCount} = lists:foldl(fun({Char, Count}, {Even, Odd}) ->
                                          case Count rem 2 of
                                              0 -> {Even + Count, Odd};
                                              _ -> {Even, Odd + 1}
                                          end
                                      end, {0, 0}, CharCounts),
    % For the palindrome, add all the even counts, and at most one odd count can be used as a center
    EvenCount + min(OddCount, 1).

%% Helper function to count occurrences of each character.
-spec count_chars(unicode:unicode_binary()) -> [{char(), integer()}].
count_chars(S) ->
    lists:foldl(fun(C, Acc) ->
                    case lists:keyfind(C, 1, Acc) of
                        {C, Count} -> [{C, Count + 1} | lists:keydelete(C, 1, Acc)];
                        false -> [{C, 1} | Acc]
                    end
                end, [], S).
