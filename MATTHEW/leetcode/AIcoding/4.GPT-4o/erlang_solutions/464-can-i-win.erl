-module(solution).
-export([can_i_win/2]).

%% Determine if the first player can force a win.
-spec can_i_win(integer(), integer()) -> boolean().
can_i_win(MaxChoosableInteger, DesiredTotal) ->
    %% Edge case where the total is zero.
    case DesiredTotal =< 0 of
        true -> true;
        false -> 
            %% Call the helper function with initial state.
            can_i_win_helper(MaxChoosableInteger, DesiredTotal, 0, #{})
    end.

%% Helper function for memoization and determining the winner.
-spec can_i_win_helper(integer(), integer(), integer(), map()) -> boolean().
can_i_win_helper(MaxChoosableInteger, DesiredTotal, CurrentTotal, Memo) ->
    %% Check if the result has already been memoized.
    case maps:find({CurrentTotal, MaxChoosableInteger}, Memo) of
        {ok, Result} -> Result;
        error ->
            %% Try every choice from 1 to MaxChoosableInteger.
            %% Check if any move results in a forced win for the current player.
            Result = lists:foldl(fun(Choice, Acc) ->
                        if
                            CurrentTotal + Choice >= DesiredTotal -> true;
                            true -> 
                                %% Try next player move, switching the roles.
                                case can_i_win_helper(MaxChoosableInteger, DesiredTotal, CurrentTotal + Choice, Memo) of
                                    true -> false;
                                    false -> true
                                end
                        end
                    end, 
                    false,
                    lists:seq(1, MaxChoosableInteger)),
            %% Memoize the result.
            Memo1 = maps:put({CurrentTotal, MaxChoosableInteger}, Result, Memo),
            Result
    end.
