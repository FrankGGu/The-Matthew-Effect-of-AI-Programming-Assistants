-module(split_array_into_fibonacci_sequence).
-export([split/1]).

split(Nums) ->
    split(Nums, []).

split([], _) when length([]) == 0 -> [];
split([], _) -> [];
split([H|T], Acc) ->
    case is_valid([H|T], []) of
        {true, Result} -> Result;
        false -> split(T, [])
    end.

is_valid([], Acc) ->
    case length(Acc) >= 3 of
        true -> {true, Acc};
        false -> false
    end;

is_valid([H|T], Acc) ->
    case Acc of
        [] -> is_valid(T, [H]);
        [A] -> is_valid(T, [A, H]);
        [A, B] -> 
            if (A + B) == H -> is_valid(T, [A, B, H]);
               true -> false
            end;
        [A, B, C | _] ->
            if (A + B) == C -> is_valid(T, [B, C, H]);
               true -> false
            end
    end.