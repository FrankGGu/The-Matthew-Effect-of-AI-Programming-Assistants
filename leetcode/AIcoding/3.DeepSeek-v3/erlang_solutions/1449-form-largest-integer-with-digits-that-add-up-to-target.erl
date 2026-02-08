-module(solution).
-export([largest_number/2]).

largest_number(Costs, Target) ->
    DP = array:new(Target + 1, {default, -1}),
    DP1 = array:set(0, 0, DP),
    {DP2, _} = lists:foldl(fun(I, {D, _}) ->
        lists:foldl(fun(J, {D1, _}) ->
            if
                I >= J ->
                    case array:get(I - J, D1) of
                        -1 -> {D1, 0};
                        V -> 
                            NewVal = V + 1,
                            case array:get(I, D1) of
                                -1 -> {array:set(I, NewVal, D1), 0};
                                OldVal when NewVal >= OldVal -> {array:set(I, NewVal, D1), 0};
                                _ -> {D1, 0}
                            end
                    end;
                true -> {D1, 0}
            end
        end, {D, 0}, Costs)
    end, {DP1, 0}, lists:seq(1, Target)),
    case array:get(Target, DP2) of
        -1 -> "0";
        _ -> build_number(DP2, Costs, Target)
    end.

build_number(DP, Costs, Target) ->
    build_number(DP, Costs, Target, []).

build_number(_, _, 0, Acc) ->
    case Acc of
        [] -> "0";
        _ -> lists:concat(lists:reverse(Acc))
    end;
build_number(DP, Costs, Target, Acc) ->
    {Digit, NextTarget} = lists:foldl(fun(I, {D, T}) ->
        Cost = lists:nth(I, Costs),
        if
            Target >= Cost ->
                case array:get(Target - Cost, DP) of
                    -1 -> {D, T};
                    V ->
                        case array:get(Target, DP) of
                            V1 when V + 1 =:= V1 ->
                                if
                                    I > D -> {I, Target - Cost};
                                    true -> {D, T}
                                end;
                            _ -> {D, T}
                        end
                end;
            true -> {D, T}
        end
    end, {0, 0}, lists:seq(1, length(Costs))),
    if
        Digit =:= 0 -> "0";
        true -> build_number(DP, Costs, NextTarget, [Digit | Acc])
    end.