-module(maximize_active_section).
-export([solve/1]).

solve(nums) ->
    solve(nums, 0, 0, 0).

solve([], Active, Inactive, MaxActive) ->
    max(Active, MaxActive);
solve([Num | Rest], Active, Inactive, MaxActive) ->
    NewActive = Active + 1,
    case Num of
        1 ->
            solve(Rest, NewActive, Inactive, MaxActive);
        0 ->
            NewInactive = Inactive + 1,
            NewMaxActive = max(NewActive, MaxActive),
            case NewInactive of
                1 ->
                    solve(Rest, NewActive, 0, NewMaxActive);
                _ ->
                    solve(Rest, NewActive, NewInactive, NewMaxActive)
            end
    end.