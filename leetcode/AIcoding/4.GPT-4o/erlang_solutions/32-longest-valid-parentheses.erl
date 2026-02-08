-spec longest_valid_parentheses(S :: unicode:unicode_binary()) -> integer().
longest_valid_parentheses(S) ->
    longest_valid_parentheses(S, [], 0, 0).

longest_valid_parentheses([], [], Max, _) -> Max;
longest_valid_parentheses([], Stack, Max, _) -> Max;
longest_valid_parentheses([Parenthesis | Rest], Stack, Max, Count) when Parenthesis == $(`()`) ->
    longest_valid_parentheses(Rest, tl(Stack), max(Count, length(Stack) + 2), 0);
longest_valid_parentheses([Parenthesis | Rest], Stack, Max, Count) when Parenthesis == $(`(`) ->
    longest_valid_parentheses(Rest, [Parenthesis | Stack], Max, Count);
longest_valid_parentheses([Parenthesis | Rest], Stack, Max, Count) when Parenthesis == $(`)`) ->
    longest_valid_parentheses(Rest, tl(Stack), Max, Count);
