-module(solution).
-export([score_of_parentheses/1]).

-spec score_of_parentheses(S :: unicode:unicode_binary() | unicode:unicode_list()) -> integer().
score_of_parentheses(S) ->
    % Initialize the stack with a 0. This 0 represents the score for the outermost
    % (global) scope, accumulating the scores of top-level balanced parentheses.
    score_of_parentheses_impl(S, [0]).

score_of_parentheses_impl([], [FinalScore]) ->
    % When the input string is fully processed, the stack should contain exactly one element,
    % which is the total accumulated score for the entire string.
    FinalScore;
score_of_parentheses_impl([$( | T], Stack) ->
    % When an opening parenthesis '(' is encountered, push a 0 onto the stack.
    % This 0 will accumulate the score for the content within this new parenthesis block.
    score_of_parentheses_impl(T, [0 | Stack]);
score_of_parentheses_impl([$) | T], [InnerScore | [OuterScore | RestStack]]) ->
    % When a closing parenthesis ')' is encountered:
    % 1. Pop the top element (InnerScore), which is the accumulated score of the content
    %    inside the current parenthesis block.
    % 2. Calculate the score for this completed block:
    %    - If InnerScore is 0 (meaning the block was '()'), its score is 1.
    %    - If InnerScore > 0 (meaning the block was '(A)', where A had score InnerScore),
    %      its score is 2 * InnerScore.
    BlockScore = max(1, 2 * InnerScore),
    % 3. Add this calculated BlockScore to the next element on the stack (OuterScore),
    %    which represents the score of the enclosing parenthesis block.
    % 4. Push the updated OuterScore back onto the stack.
    score_of_parentheses_impl(T, [OuterScore + BlockScore | RestStack]).