-module(solution).
-export([is_possible/1]).

is_possible(Edges) ->
    Degrees = lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => maps:get(A, Acc, 0) + 1, B => maps:get(B, Acc, 0) + 1}
    end, #{}, Edges),
    Count = lists:foldl(fun({_K, V}, Acc) ->
        if V rem 2 == 0 -> Acc;
           true -> Acc + 1
        end
    end, 0, maps:to_list(Degrees)),
    Count == 0 orelse (Count == 2 andalso is_even(Count)).

is_even(N) when N rem 2 == 0 -> true;
is_even(_) -> false.