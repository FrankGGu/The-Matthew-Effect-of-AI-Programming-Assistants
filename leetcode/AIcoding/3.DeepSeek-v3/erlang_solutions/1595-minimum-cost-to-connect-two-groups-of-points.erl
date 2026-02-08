-module(solution).
-export([connect_two_groups/1]).

connect_two_groups(Cost) ->
    Size1 = length(Cost),
    Size2 = length(hd(Cost)),
    Mask = (1 bsl Size2) - 1,
    DP = maps:new(),
    DP1 = maps:put({0, 0}, 0, DP),
    {Ans, _} = lists:foldl(fun(I, {D, _}) ->
        lists:foldl(fun(J, {D1, _}) ->
            lists:foldl(fun({Mask1, Sum}, {D2, _}) ->
                NewMask1 = Mask1 bor (1 bsl J),
                NewSum = Sum + lists:nth(J + 1, lists:nth(I + 1, Cost)),
                case maps:get({I + 1, NewMask1}, D2, infinity) of
                    infinity ->
                        {maps:put({I + 1, NewMask1}, NewSum, D2), D2};
                    OldSum when NewSum < OldSum ->
                        {maps:put({I + 1, NewMask1}, NewSum, D2), D2};
                    _ ->
                        {D2, D2}
                end
            end, {D1, D1}, maps:to_list(D1))
        end, {D, D}, lists:seq(0, Size2 - 1))
    end, {DP1, DP1}, lists:seq(0, Size1 - 1)),
    FinalDP = maps:get({Size1, Mask}, Ans),
    lists:foldl(fun(J, Min) ->
        lists:foldl(fun({_, Sum}, Acc) ->
            MinCost = lists:min([lists:nth(J + 1, lists:nth(K + 1, Cost)) || K <- lists:seq(0, Size1 - 1)]),
            min(Acc, Sum + MinCost)
        end, Min, maps:to_list(Ans))
    end, FinalDP, lists:seq(0, Size2 - 1)).