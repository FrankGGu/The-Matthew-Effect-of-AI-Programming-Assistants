-module(solution).
-export([minimum_effort/1]).

minimum_effort(Leaves) ->
    N = length(Leaves),
    dp(Leaves, N).

dp(Leaves, N) ->
    Memo = dict:new(),
    dp_helper(Leaves, N, 0, 2, Memo).

dp_helper(Leaves, N, I, Stage, Memo) ->
    case dict:find( {I, Stage}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            case {I, Stage} of
                {N, 0} ->
                    case lists:nth(N, Leaves) of
                        $r -> 0;
                        $y -> infinity
                    end;
                {N, 1} ->
                    infinity;
                {N, 2} ->
                    infinity;
                _ ->
                    case Stage of
                        0 ->
                            case lists:nth(I+1, Leaves) of
                                $r ->
                                    R1 = dp_helper(Leaves, N, I+1, 0, Memo);
                                    R2 = dp_helper(Leaves, N, I+1, 1, Memo) + 1;
                                    Res = min(R1, R2);
                                    dict:store({I, Stage}, Res, Memo),
                                    Res;
                                $y ->
                                    R1 = dp_helper(Leaves, N, I+1, 0, Memo) + 1;
                                    R2 = dp_helper(Leaves, N, I+1, 1, Memo);
                                    Res = min(R1, R2);
                                    dict:store({I, Stage}, Res, Memo),
                                    Res
                            end;
                        1 ->
                            case lists:nth(I+1, Leaves) of
                                $r ->
                                    R2 = dp_helper(Leaves, N, I+1, 1, Memo);
                                    R3 = dp_helper(Leaves, N, I+1, 2, Memo) + 1;
                                    Res = min(R2, R3);
                                    dict:store({I, Stage}, Res, Memo),
                                    Res;
                                $y ->
                                    R2 = dp_helper(Leaves, N, I+1, 1, Memo) + 1;
                                    R3 = dp_helper(Leaves, N, I+1, 2, Memo);
                                    Res = min(R2, R3);
                                    dict:store({I, Stage}, Res, Memo),
                                    Res
                            end;
                        2 ->
                            case lists:nth(I+1, Leaves) of
                                $r ->
                                    Res = dp_helper(Leaves, N, I+1, 2, Memo);
                                    dict:store({I, Stage}, Res, Memo),
                                    Res;
                                $y ->
                                    Res = dp_helper(Leaves, N, I+1, 2, Memo) + 1;
                                    dict:store({I, Stage}, Res, Memo),
                                    Res
                            end
                    end
            end.
min(A, B) ->
    if A < B -> A;
    true -> B
    end.

infinity() -> 1000000.