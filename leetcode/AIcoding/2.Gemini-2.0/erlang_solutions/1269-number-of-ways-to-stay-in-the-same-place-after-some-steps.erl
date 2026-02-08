-module(number_of_ways).
-export([num_ways/3]).

num_ways(Steps, ArrLen, Pos) ->
    memo(Steps, ArrLen, Pos, #{}).

memo(0, _, 0, Memo) ->
    maps:get({0, 0}, Memo, 1);
memo(0, _, _, _) ->
    0.

memo(Steps, ArrLen, Pos, Memo) ->
    case maps:is_key({Steps, Pos}, Memo) of
        true ->
            maps:get({Steps, Pos}, Memo);
        false ->
            MaxPos = min(Steps, ArrLen - 1),
            case Pos > MaxPos of
                true ->
                    put_memo(Steps, Pos, 0, Memo);
                false ->
                    MoveLeft = case Pos > 0 of
                                    true ->
                                        memo(Steps - 1, ArrLen, Pos - 1, Memo);
                                    false ->
                                        0
                                end,
                    MoveRight = case Pos < ArrLen - 1 of
                                     true ->
                                         memo(Steps - 1, ArrLen, Pos + 1, Memo);
                                     false ->
                                         0
                                 end,
                    Stay = memo(Steps - 1, ArrLen, Pos, Memo),
                    Result = (MoveLeft + MoveRight + Stay) rem 1000000007,
                    put_memo(Steps, Pos, Result, Memo)
            end
    end.

put_memo(Steps, Pos, Result, Memo) ->
    maps:put({Steps, Pos}, Result, Memo).