-module(solution).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(S) ->
    % Initialize the accumulator function with index 0, the input string,
    % a stack containing -1 (as a base for calculating lengths), and max_len 0.
    longest_valid_parentheses_acc(0, S, [-1], 0).

longest_valid_parentheses_acc(_Index, [], _Stack, MaxLen) ->
    MaxLen;

longest_valid_parentheses_acc(Index, [$(|Rest], Stack, MaxLen) ->
    longest_valid_parentheses_acc(Index + 1, Rest, [Index|Stack], MaxLen);

longest_valid_parentheses_acc(Index, [$)|Rest], Stack, MaxLen) ->
    % Pop the top element from the stack.
    % Stack is guaranteed to have at least one element (the initial -1 or a previous ')' index).
    [_|StackTail] = Stack,
    case StackTail of
        [] -> % If the stack becomes empty after popping, it means the current ')'
              % does not have a matching '('. Push the current index as the new base.
            longest_valid_parentheses_acc(Index + 1, Rest, [Index], MaxLen);
        [Top|_] -> % If the stack is not empty, the top element is the index of the
                   % last unmatched '('. Calculate the length of the current valid substring.
            CurrentLen = Index - Top,
            NewMaxLen = erlang:max(MaxLen, CurrentLen), % Update max_len if current length is greater.
            longest_valid_parentheses_acc(Index + 1, Rest, StackTail, NewMaxLen)
    end.