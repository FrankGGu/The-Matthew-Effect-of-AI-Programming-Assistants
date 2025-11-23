-module(word_break_ii).
-export([word_break/2]).

word_break(Word, Words) ->
    word_break(Word, Words, dict:new(), []).

word_break(_, _, _, Result) when Result /= [] -> Result;
word_break([], _, _, _) -> [""];
word_break(Word, Words, Memo, _) ->
    case dict:is_key(Word, Memo) of
        true -> dict:fetch(Word, Memo);
        false ->
            Results = [],
            WordLength = length(Word),
            WordsList = lists:usort(Words),
            Lists = lists:foldl(fun(WordPart, Acc) ->
                                        if
                                            length(WordPart) > WordLength -> Acc;
                                            true ->
                                                case string:prefix(Word, WordPart) of
                                                    nomatch -> Acc;
                                                    _ ->
                                                        Sub = string:substr(Word, length(WordPart)+1),
                                                        case word_break(Sub, Words, Memo, []) of
                                                            [] -> Acc;
                                                            SubResults ->
                                                                lists:foldl(fun(SubResult, Acc2) ->
                                                                                    case SubResult of
                                                                                        "" -> [WordPart | Acc2];
                                                                                        _ -> [WordPart ++ " " ++ SubResult | Acc2]
                                                                                    end
                                                                                end, Acc, SubResults)
                                                        end
                                                end
                                        end
                                    end, Results, WordsList),
            NewMemo = dict:store(Word, Lists, Memo),
            case Lists of
                [] -> [];
                _ -> Lists
            end.