-module(solution).
-export([word_break_ii/2]).

word_break_ii(S, WordDict) ->
    DictSet = sets:from_list(WordDict),
    {Result, _FinalMemo} = solve(S, DictSet, 0, maps:new()),
    Result.

solve(S, DictSet, Index, Memo) when Index == length(S) ->
    {[""], Memo};
solve(S, DictSet, Index, Memo) ->
    case maps:find(Index, Memo) of
        {ok, CachedResult} ->
            {CachedResult, Memo};
        error ->
            LenS = length(S),
            {Results, UpdatedMemo} = lists:foldl(
                fun(I, {AccResults, CurrentMemo}) ->
                    Word = string:substr(S, Index + 1, I - Index + 1),
                    case sets:is_element(Word, DictSet) of
                        true ->
                            {Suffixes, NewMemo} = solve(S, DictSet, I + 1, CurrentMemo),
                            NewAccResults = lists:foldl(
                                fun(Suffix, Acc2) ->
                                    Sentence = if Suffix == "" -> Word;
                                                 true -> Word ++ " " ++ Suffix
                                               end,
                                    [Sentence | Acc2]
                                end, AccResults, Suffixes),
                            {NewAccResults, NewMemo};
                        false ->
                            {AccResults, CurrentMemo}
                    end
                end, {[], Memo}, lists:seq(Index, LenS - 1)),
            FinalMemo = maps:put(Index, Results, UpdatedMemo),
            {Results, FinalMemo}
    end.