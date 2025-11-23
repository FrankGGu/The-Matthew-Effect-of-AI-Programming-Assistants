-module(solution).
-export([group_the_people/1]).

group_the_people(Sizes) ->
    group_the_people(Sizes, [], []).

group_the_people([], Acc, Result) ->
    lists:reverse(Result);
group_the_people([H | T], Acc, Result) ->
    NewAcc = [H | Acc],
    case length(NewAcc) of
        H ->
            group_the_people(T, [], [lists:reverse(NewAcc) | Result]);
        _ ->
            group_the_people(T, NewAcc, Result)
    end.