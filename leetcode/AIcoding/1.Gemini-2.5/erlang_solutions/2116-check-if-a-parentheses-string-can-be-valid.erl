-module(solution).
-export([can_be_valid_parentheses/2]).

can_be_valid_parentheses(S, Locked) ->
    N = length(S),
    if
        N rem 2 =/= 0 ->
            false;
        true ->
            CharLockedList = lists:zip(S, Locked),

            % Pass 1: Left to Right
            % State: {Balance, Wildcards, IsValid}
            % Balance: net count of locked '(' (+1) and ')' (-1)
            % Wildcards: count of '0's encountered
            % IsValid: boolean indicating if condition (Balance + Wildcards >= 0) has been violated
            {_, _, Pass1OK} = lists:foldl(
                fun({Char, LockedChar}, {AccBalance, AccWildcards, AccIsValid}) ->
                    if
                        not AccIsValid -> {AccBalance, AccWildcards, false}; % Short-circuit if already invalid
                        true ->
                            NewBalance =
                                if
                                    LockedChar == $1 ->
                                        if
                                            Char == $( -> AccBalance + 1;
                                            Char == $) -> AccBalance - 1
                                        end;
                                    true -> AccBalance % '0' doesn't change fixed balance
                                end,
                            NewWildcards =
                                if
                                    LockedChar == $0 -> AccWildcards + 1;
                                    true -> AccWildcards
                                end,
                            NewIsValid = (NewBalance + NewWildcards >= 0),
                            {NewBalance, NewWildcards, NewIsValid}
                    end
                end,
                {0, 0, true},
                CharLockedList
            ),

            if
                not Pass1OK ->
                    false;
                true ->
                    % Pass 2: Right to Left
                    % State: {Balance, Wildcards, IsValid}
                    % Balance: net count of locked ')' (+1) and '(' (-1) when scanning from right
                    % Wildcards: count of '0's encountered
                    % IsValid: boolean indicating if condition (Balance + Wildcards >= 0) has been violated
                    {_, _, Pass2OK} = lists:foldr(
                        fun({Char, LockedChar}, {AccBalance, AccWildcards, AccIsValid}) ->
                            if
                                not AccIsValid -> {AccBalance, AccWildcards, false}; % Short-circuit if already invalid
                                true ->
                                    NewBalance =
                                        if
                                            LockedChar == $1 ->
                                                if
                                                    Char == $) -> AccBalance + 1; % ')' from right is +1
                                                    Char == $( -> AccBalance - 1  % '(' from right is -1
                                                end;
                                            true -> AccBalance
                                        end,
                                    NewWildcards =
                                        if
                                            LockedChar == $0 -> AccWildcards + 1;
                                            true -> AccWildcards
                                        end,
                                    NewIsValid = (NewBalance + NewWildcards >= 0),
                                    {NewBalance, NewWildcards, NewIsValid}
                            end
                        end,
                        {0, 0, true},
                        CharLockedList
                    ),
                    Pass2OK
            end
    end.