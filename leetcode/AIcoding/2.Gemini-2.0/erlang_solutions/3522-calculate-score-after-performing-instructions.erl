-module(calculate_score).
-export([calculate_score_after_performing_instructions/2]).

calculate_score_after_performing_instructions(S, Instructions) ->
    Len = length(S),
    {Result, _} = lists:foldl(
        fun({Index, Value}, {Acc, Modified}) ->
            if lists:nth(Index + 1, Modified) == 0 then
                {Acc, Modified}
            else
                NewAcc = Acc + Value,
                NewModified = lists:map(
                    fun(I) ->
                        case abs(Index + 1 - I) of
                            0 -> 0;
                            1 -> 0;
                            _ -> lists:nth(I, Modified)
                        end
                    end,
                    lists:seq(1, Len)
                ),
                {NewAcc, NewModified}
            end
        end,
        {0, lists:duplicate(Len, 1)},
        lists:zip(lists:seq(0, length(Instructions) - 1), Instructions)
    ),
    Result.