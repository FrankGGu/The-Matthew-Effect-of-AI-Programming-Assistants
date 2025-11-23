-module(two_sum_iv).
-export([find_target/2]).

-record(node, {val, left, right}).

find_target(_Root, _Target) ->
    find_target_1([], _Root, _Target).

find_target_1(Seen, null, _Target) ->
    false;
find_target_1(Seen, #node{val = Val, left = Left, right = Right}, Target) ->
    case lists:member(Target - Val, Seen) of
        true -> true;
        false ->
            NewSeen = [Val | Seen],
            case find_target_1(NewSeen, Left, Target) of
                true -> true;
                _ -> find_target_1(NewSeen, Right, Target)
            end
    end.