-module(redistribute_characters).
-export([can_make_equal/1]).

can_make_equal(Words) ->
    Len = length(Words),
    CharCounts = lists:foldl(
        fun(Word, Acc) ->
            lists:foldl(
                fun(Char, InnerAcc) ->
                    case maps:find(Char, InnerAcc) of
                        {ok, Count} ->
                            maps:put(Char, Count + 1, InnerAcc);
                        error ->
                            maps:put(Char, 1, InnerAcc)
                    end
                end,
                Acc,
                Word
            )
        end,
        #{},
        Words
    ),

    maps:all(
        fun(_Char, Count) ->
            Count rem Len == 0
        end,
        CharCounts
    ).