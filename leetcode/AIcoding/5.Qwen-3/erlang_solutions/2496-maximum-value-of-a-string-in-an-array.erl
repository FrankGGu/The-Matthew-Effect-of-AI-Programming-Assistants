-module(max_value_of_a_string_in_an_array).
-export([max_value_of_string/1]).

max_value_of_string(Strs) ->
    lists:max([value(S) || S <- Strs]).

value(S) ->
    lists:foldl(fun(Char, Acc) ->
                        case Char of
                            $0 -> Acc * 10 + 0;
                            $1 -> Acc * 10 + 1;
                            $2 -> Acc * 10 + 2;
                            $3 -> Acc * 10 + 3;
                            $4 -> Acc * 10 + 4;
                            $5 -> Acc * 10 + 5;
                            $6 -> Acc * 10 + 6;
                            $7 -> Acc * 10 + 7;
                            $8 -> Acc * 10 + 8;
                            $9 -> Acc * 10 + 9;
                            _ -> Acc
                        end
                end, 0, S).