-module(solution).
-export([hasValidPath/1]).

-include_lib("kernel/include/array.hrl").

hasValidPath(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Path length must be even for balance to be 0 at the end
    PathLength = M + N - 1,
    if PathLength rem 2 /= 0 ->
        false;
    true ->
        ok
    end,

    % Start must be '('
    Char00 = lists:nth(1, lists:nth(1, Grid)),
    if Char00 == $)->
        false;
    true ->
        ok
    end,

    % End must be ')'
    CharMN = lists:nth(N, lists:nth(M, Grid)),
    if CharMN == $(->
        false;
    true ->
        ok
    end,

    % DP table: array of arrays of sets
    % Each element DP[R][C] is a set of possible balances at (R, C)
    DP = array:new({list, {0, M-1}, {0, N-1}, sets:new()}),

    % Base case: DP[0][0]
    % If Grid[0][0] is '(', balance is 1. Otherwise, it's impossible (already checked).
    DP1 = array:set({0, 0}, sets:add_element(1, sets:new()), DP),

    % Fill DP table
    DP_Final = fill_dp(0, 0, M, N, Grid, DP1),

    % Final check
    FinalBalances = array:get({M-1, N-1}, DP_Final),
    sets:is_element(0, FinalBalances).

fill_dp(R, C, M, N, Grid, DP) ->
    if R >= M ->
        DP;
    true ->
        if C >= N ->
            fill_dp(R + 1, 0, M, N, Grid, DP);
        true ->
            CurrentDP = if R == 0 andalso C == 0 ->
                            DP;
                        true ->
                            Char = lists:nth(C+1, lists:nth(R+1, Grid)),
                            Delta = if Char == $( then 1 else -1 end,

                            PossibleBalances = sets:new(),

                            % From above (R-1, C)
                            PossibleBalancesFromUp = if R > 0 ->
                                                         PrevBalancesFromUp = array:get({R-1, C}, DP),
                                                         lists:foldl(fun(PrevBalance, Acc) ->
                                                                         NewBalance = PrevBalance + Delta,
                                                                         if NewBalance >= 0 ->
                                                                             sets:add_element(NewBalance, Acc);
                                                                         true ->
                                                                             Acc
                                                                         end
                                                                     end, PossibleBalances, sets:to_list(PrevBalancesFromUp));
                                                     true ->
                                                         PossibleBalances
                                                     end,

                            % From left (R, C-1)
                            PossibleBalancesFromLeft = if C > 0 ->
                                                           PrevBalancesFromLeft = array:get({R, C-1}, DP),
                                                           lists:foldl(fun(PrevBalance, Acc) ->
                                                                           NewBalance = PrevBalance + Delta,
                                                                           if NewBalance >= 0 ->
                                                                               sets:add_element(NewBalance, Acc);
                                                                           true ->
                                                                               Acc
                                                                           end
                                                                       end, PossibleBalancesFromUp, sets:to_list(PrevBalancesFromLeft));
                                                       true ->
                                                           PossibleBalancesFromUp
                                                       end,
                            array:set({R, C}, PossibleBalancesFromLeft, DP)
                        end,
            fill_dp(R, C + 1, M, N, Grid, CurrentDP)
        end
    end.