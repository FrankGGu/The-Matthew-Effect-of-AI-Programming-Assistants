-module(number_of_ways).
-export([number_of_ways/3]).

number_of_ways(target, types) ->
    number_of_ways_helper(target, types, []).

number_of_ways_helper(0, _, _) ->
    1;
number_of_ways_helper(Target, [], _) when Target > 0 ->
    0;
number_of_ways_helper(Target, [{Points, Count} | Rest], Memo) ->
    case lists:keyfind({Target, {Points, Count}}, 1, Memo) of
        false ->
            Ways1 =
                lists:sum([
                    number_of_ways_helper(Target - Points * I, Rest, Memo)
                 || I <- lists:seq(0, Count), Target - Points * I >= 0
                ]),
            number_of_ways_helper(Target, Rest, [{Target, {Points, Count}, Ways1} | Memo]);
        {_, {_, _}, Ways} ->
            Ways
    end.