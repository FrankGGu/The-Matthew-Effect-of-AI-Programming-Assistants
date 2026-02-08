-module(word_break_ii).
-export([word_break/2]).

word_break(S, WordDict) ->
    Dict = sets:from_list(WordDict),
    N = length(S),
    DP = array:new(N + 1, {default, []}),
    DP1 = array:set(0, [[""]], DP),
    DP2 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case array:get(J, Acc1) of
                [] -> Acc1;
                Prefixes ->
                    Word = string:sub_string(S, J + 1, I),
                    case sets:is_element(Word, Dict) of
                        true ->
                            Existing = array:get(I, Acc1),
                            New = lists:flatmap(fun(Prefix) ->
                                case Prefix of
                                    [""] -> [[Word]];
                                    _ -> [Prefix ++ [Word]]
                                end
                            end, Prefixes),
                            array:set(I, Existing ++ New, Acc1);
                        false -> Acc1
                    end
            end
        end, Acc, lists:seq(0, I - 1))
    end, DP1, lists:seq(1, N)),
    Result = array:get(N, DP2),
    lists:map(fun(List) ->
        string:join(lists:filter(fun(X) -> X =/= "" end, List), " ")
    end, Result).