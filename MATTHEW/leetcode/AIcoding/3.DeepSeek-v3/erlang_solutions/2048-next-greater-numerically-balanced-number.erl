-module(solution).
-export([next_beautiful_number/1]).

next_beautiful_number(N) ->
    Next = N + 1,
    case is_balanced(Next) of
        true -> Next;
        false -> next_beautiful_number(Next)
    end.

is_balanced(N) ->
    Digits = integer_to_list(N),
    Counts = lists:foldl(fun(D, Acc) ->
                            maps:update_with(D, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Digits),
    lists:all(fun({D, C}) -> 
                D1 = D - $0,
                D1 =:= C 
              end, maps:to_list(Counts)).