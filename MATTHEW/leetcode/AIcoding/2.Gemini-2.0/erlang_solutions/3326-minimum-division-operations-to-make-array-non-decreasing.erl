-module(min_division_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    min_operations(Nums, 0, 1, []).

min_operations([], OpCount, _, _) ->
    OpCount;
min_operations([H|T], OpCount, Divisor, History) ->
    case check_history(H, Divisor, History) of
        {true, NewDivisor, NewHistory} ->
            min_operations(T, OpCount, NewDivisor, NewHistory);
        false ->
            Op1 = min_operations([H div 2 | T], OpCount + 1, Divisor * 2, History),
            Op2 = min_operations([H|T], OpCount, Divisor * 2, History),
            min(Op1, Op2)
    end.

check_history(H, Divisor, History) ->
    case History of
        [] ->
            {true, Divisor, [{H, Divisor}]};
        [{PrevH, PrevDivisor} | _] ->
            if H >= PrevH * Divisor / PrevDivisor ->
                {true, Divisor, [{H, Divisor} | History]}
            else
                false
            end
    end.

min(A, B) ->
    if A < B -> A;
    true -> B
    end.