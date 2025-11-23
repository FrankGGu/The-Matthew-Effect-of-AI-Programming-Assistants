-module(guess_number_ii).
-export([get_money_amount/1]).

get_money_amount(N) ->
    Memo = dict:new(),
    get_money_amount(1, N, Memo).

get_money_amount(Start, End, Memo) ->
    case Start >= End of
        true -> 0;
        false ->
            case dict:find({Start, End}, Memo) of
                {ok, Value} -> Value;
                error ->
                    Result = get_min_money(Start, End, Memo),
                    dict:store({Start, End}, Result, Memo),
                    Result
            end
    end.

get_min_money(Start, End, Memo) ->
    lists:foldl(
        fun(I, Acc) ->
            Cost = I + max(get_money_amount(Start, I - 1, Memo), get_money_amount(I + 1, End, Memo)),
            min(Acc, Cost)
        end,
        infinity,
        lists:seq(Start, End)
    ).

infinity -> 16#ffffffff.