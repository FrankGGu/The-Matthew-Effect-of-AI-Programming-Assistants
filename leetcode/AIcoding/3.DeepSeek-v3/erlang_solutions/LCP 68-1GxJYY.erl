-module(solution).
-export([beautiful_bouquet/2]).

beautiful_bouquet(Flowers, K) ->
    Count = maps:new(),
    MaxLen = 0,
    Left = 1,
    {Ans, _, _} = lists:foldl(fun(Flower, {AnsAcc, LeftAcc, CountAcc}) ->
        CountAcc1 = maps:update_with(Flower, fun(V) -> V + 1 end, 1, CountAcc),
        case maps:get(Flower, CountAcc1) > K of
            true ->
                {NewLeft, NewCount} = adjust_left(LeftAcc, Flower, Flowers, CountAcc1, K),
                {AnsAcc, NewLeft, NewCount};
            false ->
                {AnsAcc + (length(Flowers) - LeftAcc + 1, LeftAcc, CountAcc1}
        end
    end, {0, Left, Count}, lists:seq(1, length(Flowers))),
    Ans.

adjust_left(Left, Flower, Flowers, Count, K) ->
    case Left =< length(Flowers) andalso maps:get(Flower, Count) > K of
        true ->
            LeftFlower = lists:nth(Left, Flowers),
            NewCount = maps:update_with(LeftFlower, fun(V) -> V - 1 end, Count),
            adjust_left(Left + 1, Flower, Flowers, NewCount, K);
        false ->
            {Left, Count}
    end.