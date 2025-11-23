-module(solution).
-export([good_mornings/2]).

good_mornings(Security, Time) ->
    N = length(Security),
    if N < 2 * Time + 1 -> [];
       true ->
           Left = calculate_left(Security),
           Right = calculate_right(Security),
           check_conditions(Left, Right, Time, 0, [])
    end.

calculate_left(Security) ->
    {_LastVal, RevLeft} = lists:foldl(fun(Val, {PrevVal, Acc}) ->
                                           NewLen = if Acc == [] -> 1; PrevVal >= Val -> hd(Acc) + 1; true -> 1 end,
                                           {Val, [NewLen | Acc]}
                                    end, {hd(Security), [1]}, tl(Security)),
    lists:reverse(RevLeft).

calculate_right(Security) ->
    RevSec = lists:reverse(Security),
    {_LastVal, RevRightRev} = lists:foldl(fun(Val, {PrevVal, Acc}) ->
                                              NewLen = if Acc == [] -> 1; PrevVal <= Val -> hd(Acc) + 1; true -> 1 end,
                                              {Val, [NewLen | Acc]}
                                       end, {hd(RevSec), [1]}, tl(RevSec)),
    lists:reverse(RevRightRev).

check_conditions(Left, Right, Time, Index, Acc) ->
    check_conditions_impl(Left, Right, Time, Index, Acc).

check_conditions_impl([], [], _Time, _Index, Acc) -> lists:reverse(Acc);
check_conditions_impl([L | Ls], [R | Rs], Time, Index, Acc) ->
    NewAcc = if (L - 1) >= Time and (R - 1) >= Time -> [Index | Acc]; true -> Acc end,
    check_conditions_impl(Ls, Rs, Time, Index + 1, NewAcc).