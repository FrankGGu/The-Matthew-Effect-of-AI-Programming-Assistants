-module(solution).
-export([canIWin/2]).

-include_lib("kernel/include/gb_trees.hrl").

canIWin(MaxChoosableInteger, DesiredTotal) ->
    if DesiredTotal =< 0 -> true;
       true ->
            MaxSum = MaxChoosableInteger * (MaxChoosableInteger + 1) div 2,
            if MaxSum < DesiredTotal -> false;
               true ->
                    InitialMemo = gb_trees:empty(),
                    {Result, _FinalMemo} = can_win_recursive(0, 0, MaxChoosableInteger, DesiredTotal, InitialMemo),
                    Result
            end
    end.

can_win_recursive(Mask, CurrentSum, MaxChoosableInteger, DesiredTotal, MemoTree) ->
    if CurrentSum >= DesiredTotal ->
        {false, MemoTree};
    true ->
        case gb_trees:lookup(Mask, MemoTree) of
            {value, Result} -> {Result, MemoTree};
            _ ->
                {Result, NewMemoTree} = try_all_moves(Mask, CurrentSum, MaxChoosableInteger, DesiredTotal, MemoTree, MaxChoosableInteger),
                {Result, gb_trees:insert(Mask, Result, NewMemoTree)}
        end
    end.

try_all_moves(_Mask, _CurrentSum, _MaxChoosableInteger, _DesiredTotal, MemoTree, 0) ->
    {false, MemoTree};
try_all_moves(Mask, CurrentSum, MaxChoosableInteger, DesiredTotal, MemoTree, CurrentInt) ->
    Bit = 1 bsl (CurrentInt - 1),
    if (Mask band Bit) == 0 ->
        NewSum = CurrentSum + CurrentInt,
        if NewSum >= DesiredTotal ->
            {true, MemoTree};
        true ->
            NewMask = Mask bor Bit,
            {OpponentCanWin, UpdatedMemoTree1} = can_win_recursive(NewMask, NewSum, MaxChoosableInteger, DesiredTotal, MemoTree),
            if not OpponentCanWin ->
                {true, UpdatedMemoTree1};
            true ->
                try_all_moves(Mask, CurrentSum, MaxChoosableInteger, DesiredTotal, UpdatedMemoTree1, CurrentInt - 1)
            end
        end;
    true ->
        try_all_moves(Mask, CurrentSum, MaxChoosableInteger, DesiredTotal, MemoTree, CurrentInt - 1)
    end.