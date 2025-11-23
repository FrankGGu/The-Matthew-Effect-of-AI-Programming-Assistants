-module(solution).
-export([find_substring/2]).

find_substring(S, Words) ->
    case Words of
        [] -> [];
        _ ->
            WordLen = length(hd(Words)),
            TotalLen = length(Words) * WordLen,
            WordCount = length(Words),
            WordMap = lists:foldl(fun(Word, Acc) ->
                dict:update_counter(Word, 1, Acc)
            end, dict:new(), Words),
            SList = string:to_graphemes(S),
            find_substring(SList, WordMap, WordLen, TotalLen, WordCount, 0, [])
    end.

find_substring(S, _, WordLen, TotalLen, _, Index, Acc) when Index + TotalLen > length(S) ->
    lists:reverse(Acc);
find_substring(S, WordMap, WordLen, TotalLen, WordCount, Index, Acc) ->
    case check_window(S, WordMap, WordLen, WordCount, Index) of
        true ->
            find_substring(S, WordMap, WordLen, TotalLen, WordCount, Index + 1, [Index | Acc]);
        false ->
            find_substring(S, WordMap, WordLen, TotalLen, WordCount, Index + 1, Acc)
    end.

check_window(S, WordMap, WordLen, WordCount, Index) ->
    case check_window(S, WordMap, WordLen, WordCount, Index, dict:new(), 0) of
        {true, _} -> true;
        _ -> false
    end.

check_window(_, _, WordLen, WordCount, _, _, Count) when Count =:= WordCount ->
    {true, done};
check_window(S, OriginalMap, WordLen, WordCount, Index, CurrentMap, Count) ->
    Start = Index + Count * WordLen,
    case Start + WordLen > length(S) of
        true -> false;
        false ->
            Word = string:slice(S, Start, WordLen),
            case dict:find(Word, OriginalMap) of
                {ok, OriginalCount} ->
                    case dict:find(Word, CurrentMap) of
                        {ok, CurrentCount} when CurrentCount < OriginalCount ->
                            NewMap = dict:update_counter(Word, 1, CurrentMap),
                            check_window(S, OriginalMap, WordLen, WordCount, Index, NewMap, Count + 1);
                        {ok, _} ->
                            false;
                        error ->
                            NewMap = dict:store(Word, 1, CurrentMap),
                            check_window(S, OriginalMap, WordLen, WordCount, Index, NewMap, Count + 1)
                    end;
                error ->
                    false
            end
    end.