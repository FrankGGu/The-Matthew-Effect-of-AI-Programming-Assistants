-module(solution).
-export([earliestAndLatest/3]).

-record(memo, {table}).

earliestAndLatest(N, FirstPlayer, SecondPlayer) ->
    P1 = min(FirstPlayer, SecondPlayer),
    P2 = max(FirstPlayer, SecondPlayer),

    MemoTable = ets:new(memo_table, [set, protected, named_table]),

    Result = solve(N, P1, P2, #memo{table = MemoTable}),

    ets:delete(MemoTable),
    Result.

solve(N, P1, P2, Memo) when P1 > P2 ->
    solve(N, P2, P1, Memo);
solve(N, P1, P2, Memo) ->
    case P1 + P2 == N + 1 of
        true -> {1, 1};
        false ->
            case ets:lookup(Memo#memo.table, {N, P1, P2}) of
                [{_, Result}] -> Result;
                [] ->
                    MinRounds = lists:foldl(fun(X, Acc) -> min(X, Acc) end, infinity, []),
                    MaxRounds = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, []),

                    NextN = (N + 1) div 2,

                    PossibleResults = generate_possible_next_states(N, P1, P2, NextN, Memo),

                    CombinedMin = lists:foldl(fun({Min, _}, AccMin) -> min(AccMin, Min) end, infinity, PossibleResults),
                    CombinedMax = lists:foldl(fun({_, Max}, AccMax) -> max(AccMax, Max) end, 0, PossibleResults),

                    Result = {1 + CombinedMin, 1 + CombinedMax},
                    ets:insert(Memo#memo.table, {{N, P1, P2}, Result}),
                    Result
            end
    end.

generate_possible_next_states(N, P1, P2, NextN, Memo) ->
    PossibleResults = [],
    generate_possible_next_states_recursive(1, NextN, 1, NextN, N, P1, P2, NextN, Memo, PossibleResults).

generate_possible_next_states_recursive(P1_New_Candidate, MaxP1_New, P2_New_Candidate, MaxP2_New, N, P1, P2, NextN, Memo, Acc) when P1_New_Candidate > MaxP1_New ->
    Acc;
generate_possible_next_states_recursive(P1_New_Candidate, MaxP1_New, P2_New_Candidate, MaxP2_New, N, P1, P2, NextN, Memo, Acc) when P2_New_Candidate > MaxP2_New ->
    generate_possible_next_states_recursive(P1_New_Candidate + 1, MaxP1_New, P1_New_Candidate + 1, MaxP2_New, N, P1, P2, NextN, Memo, Acc);
generate_possible_next_states_recursive(P1_New_Candidate, MaxP1_New, P2_New_Candidate, MaxP2_New, N, P1, P2, NextN, Memo, Acc) ->
    P1_Can_Map = (P1 == 2 * P1_New_Candidate - 1) or (P1 == 2 * P1_New_Candidate),
    P2_Can_Map = (P2 == 2 * P2_New_Candidate - 1) or (P2 == 2 * P2_New_Candidate),

    NewAcc = 
        if P1_Can_Map and P2_Can_Map ->
            [solve(NextN, P1_New_Candidate, P2_New_Candidate, Memo) | Acc];
        true ->
            Acc
        end,

    generate_possible_next_states_recursive(P1_New_Candidate, MaxP1_New, P2_New_Candidate + 1, MaxP2_New, N, P1, P2, NextN, Memo, NewAcc).