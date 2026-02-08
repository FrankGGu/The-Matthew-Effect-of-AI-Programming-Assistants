-module(solution).
-export([get_probability/1]).

get_probability(Balls) ->
    Total = lists:sum(Balls),
    Half = Total div 2,
    {Count, Valid} = dfs(Balls, 0, 0, 0, 0, Half),
    Valid / Count.

dfs([], Box1Count, Box2Count, Box1Distinct, Box2Distinct, Half) ->
    if
        Box1Count == Half, Box1Distinct == Box2Distinct -> {1, 1};
        Box1Count == Half -> {1, 0};
        true -> {0, 0}
    end;
dfs([0 | Rest], Box1Count, Box2Count, Box1Distinct, Box2Distinct, Half) ->
    dfs(Rest, Box1Count, Box2Count, Box1Distinct, Box2Distinct, Half);
dfs([Count | Rest], Box1Count, Box2Count, Box1Distinct, Box2Distinct, Half) ->
    {Total, Valid} = {0, 0},
    {NewTotal, NewValid} = 
        lists:foldl(fun(I, {T, V}) ->
            NewBox1Count = Box1Count + I,
            NewBox2Count = Box2Count + (Count - I),
            if
                NewBox1Count > Half; NewBox2Count > Half -> {T, V};
                true ->
                    NewBox1Distinct = if I > 0 -> Box1Distinct + 1; true -> Box1Distinct end,
                    NewBox2Distinct = if (Count - I) > 0 -> Box2Distinct + 1; true -> Box2Distinct end,
                    {T1, V1} = dfs(Rest, NewBox1Count, NewBox2Count, NewBox1Distinct, NewBox2Distinct, Half),
                    {T + T1, V + V1}
            end
        end, {Total, Valid}, lists:seq(0, Count)),
    {NewTotal, NewValid}.