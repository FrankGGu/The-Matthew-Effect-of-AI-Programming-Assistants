-module(solution).
-export([numWays/3]).

numWays(N, Relation, K) ->
    Adj = build_adj(Relation),

    % dp_prev stores the number of ways to reach each player in the previous step
    % Initial state: 1 way to be at player 0 in 0 steps
    DpPrev = #{0 => 1},

    % Iterate K times to calculate the number of ways for each step
    ResultMap = lists:foldl(
        fun(_, CurrentDp) ->
            % NextDp will store the counts for the current step
            NextDp = #{},

            % Iterate through players reachable in the previous step
            maps:fold(
                fun(FromPlayer, Count, Acc) ->
                    % Find all players that FromPlayer can pass information to
                    case maps:find(FromPlayer, Adj) of
                        {ok, Targets} ->
                            % For each target, add the current count
                            lists:foldl(
                                fun(TargetPlayer, InnerAcc) ->
                                    maps:update_with(TargetPlayer, 
                                                     fun(Val) -> Val + Count end, 
                                                     Count, 
                                                     InnerAcc)
                                end, 
                                Acc, 
                                Targets);
                        error ->
                            % If FromPlayer has no outgoing edges, just return the accumulator
                            Acc
                    end
                end, 
                NextDp, 
                CurrentDp
            )
        end, 
        DpPrev, 
        lists:seq(1, K) % Iterate K times
    ),

    % The final answer is the number of ways to reach player N-1 in K steps
    maps:get(N - 1, ResultMap, 0).

build_adj(Relation) ->
    lists:foldl(
        fun([From, To], Acc) ->
            maps:update_with(From, fun(L) -> [To | L] end, [To], Acc)
        end, 
        #{}, 
        Relation
    ).