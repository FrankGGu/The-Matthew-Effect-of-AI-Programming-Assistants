-module(solution).
-export([push_dominoes/1]).

push_dominoes(Dominoes) ->
    N = length(Dominoes),
    Infinity = N + 1,

    LeftRDist = calculate_left_R_dist(Dominoes, Infinity),
    RightLDist = calculate_right_L_dist(Dominoes, Infinity),

    lists:map(fun({Char, DistRFromLeft, DistLFromRight}) ->
        case Char of
            $R -> $R;
            $L -> $L;
            $. ->
                case {DistRFromLeft, DistLFromRight} of
                    {Infinity, Infinity} -> $.;
                    {Infinity, _} -> $L;
                    {_, Infinity} -> $R;
                    {DR, DL} when DR < DL -> $R;
                    {DR, DL} when DL < DR -> $L;
                    _ -> $.
                end
        end
    end, lists:zip3(Dominoes, LeftRDist, RightLDist)).

calculate_left_R_dist(Dominoes, Infinity) ->
    calculate_left_R_dist_acc(Dominoes, [], Infinity, Infinity).

calculate_left_R_dist_acc([], Acc, _CurrentRDist, _Infinity) ->
    lists:reverse(Acc);
calculate_left_R_dist_acc([H|T], Acc, CurrentRDist, Infinity) ->
    NewCurrentRDist = case H of
        $R -> 0;
        $L -> Infinity;
        $. -> if CurrentRDist == Infinity -> Infinity;
                 true -> CurrentRDist + 1
              end
    end,
    calculate_left_R_dist_acc(T, [NewCurrentRDist|Acc], NewCurrentRDist, Infinity).

calculate_right_L_dist(Dominoes, Infinity) ->
    ReversedDominoes = lists:reverse(Dominoes),
    ReversedDist = calculate_right_L_dist_acc(ReversedDominoes, [], Infinity, Infinity),
    lists:reverse(ReversedDist).

calculate_right_L_dist_acc([], Acc, _CurrentLDist, _Infinity) ->
    lists:reverse(Acc);
calculate_right_L_dist_acc([H|T], Acc, CurrentLDist, Infinity) ->
    NewCurrentLDist = case H of
        $L -> 0;
        $R -> Infinity;
        $. -> if CurrentLDist == Infinity -> Infinity;
                 true -> CurrentLDist + 1
              end
    end,
    calculate_right_L_dist_acc(T, [NewCurrentLDist|Acc], NewCurrentLDist, Infinity).