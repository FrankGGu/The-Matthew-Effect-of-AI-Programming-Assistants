-module(decremental_string_concatenation).
-export([min_cost/1]).

min_cost(Words) ->
    N = length(Words),
    memo(Words, 0, N - 1, undefined, undefined, #{}).

memo(Words, L, R, LeftChar, RightChar, Memo) ->
    case maps:get({L, R, LeftChar, RightChar}, Memo, undefined) of
        undefined ->
            case L =:= R of
                true ->
                    Word = lists:nth(L + 1, Words),
                    Cost = length(Word),
                    Memo1 = maps:put({L, R, list_to_atom([hd(Word)]), list_to_atom([lists:last(Word)])}, Cost, Memo),
                    Cost;
                false ->
                    WordL = lists:nth(L + 1, Words),
                    WordR = lists:nth(R + 1, Words),
                    LeftCharL = list_to_atom([hd(WordL)]),
                    RightCharL = list_to_atom([lists:last(WordL)]),
                    LeftCharR = list_to_atom([hd(WordR)]),
                    RightCharR = list_to_atom([lists:last(WordR)]),

                    Cost1 =
                        case RightChar of
                            LeftCharL ->
                                CostR = memo(Words, L + 1, R, RightCharL, RightChar, Memo),
                                Cost = CostR - (length(WordL) - 1),
                                Cost;
                            _ ->
                                CostR = memo(Words, L + 1, R, RightCharL, RightChar, Memo),
                                Cost = CostR + length(WordL),
                                Cost
                        end,
                    Cost2 =
                        case LeftChar of
                            RightCharR ->
                                CostL = memo(Words, L, R - 1, LeftChar, LeftCharR, Memo),
                                Cost = CostL - (length(WordR) - 1),
                                Cost;
                            _ ->
                                CostL = memo(Words, L, R - 1, LeftChar, LeftCharR, Memo),
                                Cost = CostL + length(WordR),
                                Cost
                        end,

                    MinCost = min(Cost1, Cost2),
                    Memo1 = maps:put({L, R, LeftCharL, RightCharR}, MinCost, Memo),
                    MinCost
            end;
        Cost ->
            Cost
    end.