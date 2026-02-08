-module(solution).
-export([peopleAwareOfSecret/2]).

peopleAwareOfSecret(N, delay) ->
    %% Initialize the list to track the number of people aware of the secret
    Aware = lists:duplicate(N + 1, 0),
    %% Start with the first person knowing the secret
    Aware = lists:replace(Aware, 1, 1),
    %% Process each day
    lists:foldl(fun(Day, Acc) ->
        NewAcc = lists:duplicate(N + 1, 0),
        lists:foreach(fun(Person) ->
            case lists:nth(Person, Acc) of
                1 ->
                    %% This person can tell the secret
                    lists:replace(NewAcc, Person + 1, lists:nth(Person + 1, NewAcc) + 1),
                    lists:replace(NewAcc, Person + 2, lists:nth(Person + 2, NewAcc) + 1);
                _ -> ok
            end
        end, lists:seq(1, N)),
        %% Update Aware for the next day
        lists:zipwith(fun(X, Y) -> (X + Y) rem 1000000007 end, Acc, NewAcc)
    end, Aware, lists:seq(1, delay)),
    %% Count the total number of people aware of the secret after delay days
    lists:foldl(fun(X, Acc) -> (X + Acc) rem 1000000007 end, 0, Aware).