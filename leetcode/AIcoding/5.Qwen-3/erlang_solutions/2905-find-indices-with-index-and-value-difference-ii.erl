-module(solution).
-export([oddString/1]).

oddString(Values) ->
    N = length(Values),
    lists:foldl(fun(I, Acc) ->
        case findIndex(Values, I, N) of
            false -> Acc;
            Index -> [Index | Acc]
        end
    end, [], lists:seq(0, N-1)).

findIndex(Values, I, N) ->
    lists:foldl(fun(J, Acc) ->
        if
            J == I -> Acc;
            true ->
                case abs(lists:nth(I+1, Values) - lists:nth(J+1, Values)) >= abs(I - J) of
                    true -> {true, J};
                    false -> Acc
                end
        end
    end, false, lists:seq(0, N-1)).