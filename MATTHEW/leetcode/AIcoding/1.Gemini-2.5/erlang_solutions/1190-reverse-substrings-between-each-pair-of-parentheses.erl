-module(solution).
-export([reverseParentheses/1]).

-spec reverseParentheses(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverseParentheses(S) ->
    % Convert the input string to a list of characters for easier manipulation.
    CharList = unicode:characters_to_list(S),

    % Call the accumulator function.
    % The accumulator state is a tuple {CurrentString, StackOfStrings}.
    % CurrentString: The string being built at the current level, in correct order.
    % StackOfStrings: A stack (list) of strings from outer levels, also in correct order.
    {FinalString, _} = reverse_parentheses_acc(CharList, {[], []}),

    % Convert the final list of characters back to a string (binary).
    unicode:characters_to_binary(FinalString).

reverse_parentheses_acc([], AccState) ->
    % Base case: No more characters to process. Return the final accumulated state.
    AccState;
reverse_parentheses_acc([$( | T], {CurrentString, Stack}) ->
    % When an opening parenthesis '(', push the CurrentString onto the stack
    % and start a new empty CurrentString for the deeper level.
    reverse_parentheses_acc(T, {[], [CurrentString | Stack]});
reverse_parentheses_acc([$) | T], {CurrentString, [PrevString | StackTail]}) ->
    % When a closing parenthesis ')', pop the previous string from the stack.
    % Reverse the CurrentString (which is the content of the just-closed parentheses).
    ReversedCurrent = lists:reverse(CurrentString),
    % Append the reversed content to the PrevString. This becomes the new CurrentString
    % for the outer level.
    NewCurrentString = PrevString ++ ReversedCurrent,
    reverse_parentheses_acc(T, {NewCurrentString, StackTail});
reverse_parentheses_acc([Char | T], {CurrentString, Stack}) ->
    % For any other character, append it to the CurrentString.
    reverse_parentheses_acc(T, {CurrentString ++ [Char], Stack}).