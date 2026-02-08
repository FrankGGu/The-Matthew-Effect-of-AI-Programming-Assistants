-module(solution).
-export([can_reach/3]).

can_reach(S, MinJump, MaxJump) ->
    N = length(S),
    case lists:nth(1, S) of
        $0 -> can_reach(S, MinJump, MaxJump, 1, N, 1, queue:new());
        _ -> false
    end.

can_reach(S, MinJump, MaxJump, Pos, N, Last, Q) ->
    if
        Pos + MinJump > N -> false;
        true ->
            NewQ = queue:in(Pos + MinJump, Q),
            can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, NewQ)
    end.

can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, Q) ->
    case queue:out(Q) of
        {empty, _} -> false;
        {{value, Next}, NewQ} ->
            if
                Next > Pos + MaxJump ->
                    can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, NewQ);
                Next > N ->
                    can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, NewQ);
                true ->
                    case lists:nth(Next, S) of
                        $0 ->
                            if
                                Next == N -> true;
                                Next > Last ->
                                    NewQ1 = queue:in(Next + MinJump, NewQ),
                                    can_reach_loop(S, MinJump, MaxJump, Next, N, Next, NewQ1);
                                true ->
                                    can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, NewQ)
                            end;
                        _ ->
                            can_reach_loop(S, MinJump, MaxJump, Pos, N, Last, NewQ)
                    end
            end
    end.