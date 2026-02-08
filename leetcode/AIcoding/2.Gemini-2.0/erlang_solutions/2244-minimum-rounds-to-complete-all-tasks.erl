-module(minimum_rounds).
-export([minimumRounds/1]).

minimumRounds(Tasks) ->
    Counts = lists:foldl(fun(Task, Acc) ->
        case maps:is_key(Task, Acc) of
            true -> maps:update(Task, maps:get(Task, Acc) + 1, Acc);
            false -> maps:put(Task, 1, Acc)
        end
    end, #{}, Tasks),

    minimum_rounds_helper(maps:values(Counts), 0).

minimum_rounds_helper([], Rounds) ->
    Rounds;
minimum_rounds_helper([Count | Rest], Rounds) ->
    case Count of
        1 -> -1;
        2 -> minimum_rounds_helper(Rest, Rounds + 1);
        3 -> minimum_rounds_helper(Rest, Rounds + 1);
        N when N rem 3 == 0 -> minimum_rounds_helper(Rest, Rounds + N div 3);
        N when N rem 3 == 1 -> minimum_rounds_helper(Rest, Rounds + (N div 3) - 1 + 2);
        N -> minimum_rounds_helper(Rest, Rounds + (N div 3) + 1)
    end.