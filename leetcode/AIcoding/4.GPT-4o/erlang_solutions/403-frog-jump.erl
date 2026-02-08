-module(solution).
-export([can_cross/1]).

%% can_cross/1 takes a list of stones and returns true if the frog can cross.
-spec can_cross([integer()]) -> boolean().
can_cross(Stones) ->
    can_cross(Stones, #{0 => [0]}).

%% Helper function for recursive checking.
can_cross([], _) -> false;
can_cross([_], _) -> true; %% Reached the last stone.
can_cross([Current | Rest], Memo) ->
    %% Find all possible previous jump distances.
    PreviousJumps = get_possible_jumps(Current, Memo),
    %% Try jumping to the next stones
    lists:foldl(fun(PrevJump, Acc) ->
                    NextStone = Current + PrevJump,
                    case lists:member(NextStone, Rest) of
                        true -> 
                            %% Add this jump to memo and continue checking.
                            can_cross(Rest, maps:put(NextStone, [PrevJump-1, PrevJump, PrevJump+1], Memo));
                        false -> Acc
                    end
                end, false, PreviousJumps).

%% Get possible previous jumps based on the current stone.
get_possible_jumps(Current, Memo) ->
    case maps:get(Current, Memo) of
        {ok, Jumps} -> Jumps;
        error -> []
    end.
