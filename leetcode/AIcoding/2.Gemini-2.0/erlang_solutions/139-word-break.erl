-module(word_break).
-export([word_break/2]).

word_break(S, WordDict) ->
    Len = length(S),
    DP = array:new([Len+1], {false}),
    array:set(Len, DP, true),
    word_break_helper(S, WordDict, Len, DP).

word_break_helper(S, WordDict, Len, DP) ->
    lists:foldl(
        fun(I, Acc) ->
            if array:get(I, DP) == false then
                lists:foldl(
                    fun(Word, Acc2) ->
                        WordLen = length(Word),
                        if I + WordLen =< Len andalso string:substr(S, I+1, WordLen) == Word then
                            array:set(I, DP, array:get(I+WordLen, DP)),
                            case array:get(I, DP) of
                                true ->
                                    true;
                                false ->
                                    Acc2
                            end
                        else
                            Acc2
                        end
                    end,
                    false,
                    WordDict
                ),
                Acc
            else
                Acc
            end
        end,
        true,
        lists:seq(Len-1, 0, -1)
    ),
    array:get(0, DP).