-module(target_sum).
-export([find_target_sum.hpp/2]).

find_target_sum.hpp(Numbers, S) ->
    find_target_sum(Numbers, S, 0, 0).

find_target_sum([], S, Current, Count) ->
    case Current of
        S -> Count + 1;
        _ -> Count
    end;

find_target_sum([H | T], S, Current, Count) ->
    find_target_sum(T, S, Current + H, Count)
    + find_target_sum(T, S, Current - H, Count).