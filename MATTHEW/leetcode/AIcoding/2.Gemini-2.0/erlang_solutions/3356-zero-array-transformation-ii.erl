-module(zero_array_transformation_ii).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, []).

solve([], Acc) ->
    case lists:all(fun(0) -> true; (_) -> false end, Acc) of
        true -> "Yes";
        false -> "No"
    end;
solve(Nums, Acc) ->
    N = length(Nums),
    case N of
        0 ->
            case lists:all(fun(0) -> true; (_) -> false end, Acc) of
                true -> "Yes";
                false -> "No"
            end;
        _ ->
            Max = lists:max(Nums),
            MaxIndex = find_index(Nums, Max),

            NewNums = lists:map(fun(X) -> X - min(Max, X) end, Nums),
            NewAcc = Acc ++ [Max],
            solve(NewNums, NewAcc)
    end.

find_index(List, Value) ->
    find_index(List, Value, 1).

find_index([H|T], Value, Index) ->
    case H =:= Value of
        true -> Index;
        false -> find_index(T, Value, Index + 1)
    end.