-module(solution).
-export([box_delivering/3]).

box_delivering(Boxes, PortsCount, MaxBoxes, MaxWeight) ->
    N = length(Boxes),
    DP = array:new([{size, N + 1}, {default, 0}]),
    {DP1, _} = lists:foldl(fun(I, {DPAcc, J}) ->
        TotalBoxes = 0,
        TotalWeight = 0,
        K = I,
        NewJ = case J < I of
            true -> I;
            false -> J
        end,
        {NewJ1, _, _} = lists:foldl(fun(K1, {J1, Boxes1, Weight1}) ->
            case K1 > I - MaxBoxes andalso K1 >= 1 of
                true ->
                    [Box | _] = lists:nth(K1, Boxes),
                    NewBoxes1 = Boxes1 + 1,
                    NewWeight1 = Weight1 + element(2, Box),
                    case NewBoxes1 =< MaxBoxes andalso NewWeight1 =< MaxWeight of
                        true ->
                            {max(J1, K1), NewBoxes1, NewWeight1};
                        false ->
                            {J1, Boxes1, Weight1}
                    end;
                false ->
                    {J1, Boxes1, Weight1}
            end
        end, {NewJ, 0, 0}, lists:seq(I, max(1, I - MaxBoxes + 1), -1),
        MinVal = case NewJ1 >= 1 of
            true ->
                [BoxPrev | _] = lists:nth(NewJ1, Boxes),
                case NewJ1 - 1 >= 1 of
                    true ->
                        [BoxPrevPrev | _] = lists:nth(NewJ1 - 1, Boxes),
                        case element(1, BoxPrev) =:= element(1, BoxPrevPrev) of
                            true -> array:get(NewJ1 - 1, DPAcc) + 0;
                            false -> array:get(NewJ1 - 1, DPAcc) + 1
                        end;
                    false ->
                        array:get(NewJ1 - 1, DPAcc) + 1
                end;
            false ->
                0
        end,
        DP2 = array:set(I, MinVal + 2, DPAcc),
        {DP2, NewJ1}
    end, {DP, 0}, lists:seq(1, N)),
    array:get(N, DP1).