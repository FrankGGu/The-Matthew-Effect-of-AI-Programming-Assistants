-module(solution).
-export([count_palindromic_subsequences/1]).

count_palindromic_subsequences(S) ->
    N = length(S),
    DP = lists:duplicate(N, lists:duplicate(N, 0)),
    count(S, 0, N - 1, DP).

count(S, I, J, DP) ->
    case I > J of
        true -> 0;
        false ->
            case I == J of
                true -> 1;
                false ->
                    case lists:nth(I + 1, DP) of
                        undefined ->
                            NewDP1 = update_dp(DP, I, J, 0),
                            case lists:nth(I + 1, S) == lists:nth(J + 1, S) of
                                true ->
                                    Left = I + 1,
                                    Right = J - 1,
                                    while(Left, Right, S, lists:nth(I + 1, S)),
                                    case Left > Right of
                                        true ->
                                            Res = 2 * count(S, I + 1, J - 1, NewDP1) + 2,
                                            NewDP2 = update_dp(NewDP1, I, J, Res),
                                            {Res, NewDP2};
                                        false ->
                                            case Left == Right of
                                                true ->
                                                    Res = 2 * count(S, I + 1, J - 1, NewDP1) + 1,
                                                    NewDP2 = update_dp(NewDP1, I, J, Res),
                                                    {Res, NewDP2};
                                                false ->
                                                    Res = 2 * count(S, I + 1, J - 1, NewDP1) - count(S, Left + 1, Right - 1, NewDP1),
                                                    NewDP2 = update_dp(NewDP1, I, J, Res),
                                                    {Res, NewDP2}
                                            end
                                    end;
                                false ->
                                    Res = count(S, I, J - 1, NewDP1) + count(S, I + 1, J, NewDP1) - count(S, I + 1, J - 1, NewDP1),
                                    NewDP2 = update_dp(NewDP1, I, J, Res),
                                    {Res, NewDP2}
                            end;
                        Val ->
                            {Val, DP}
                    end
            end
    end.

update_dp(DP, I, J, Val) ->
    Row = lists:nth(I + 1, DP),
    NewRow = setnth(J + 1, Row, Val),
    setnth(I + 1, DP, NewRow).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].

while(Left, Right, S, C) ->
    case Left =< Right andalso lists:nth(Left + 1, S) =/= C of
        true -> while(Left + 1, Right, S, C);
        false -> Left
    end,
    case Right >= Left andalso lists:nth(Right + 1, S) =/= C of
        true -> while(Left, Right - 1, S, C);
        false -> Right
    end.