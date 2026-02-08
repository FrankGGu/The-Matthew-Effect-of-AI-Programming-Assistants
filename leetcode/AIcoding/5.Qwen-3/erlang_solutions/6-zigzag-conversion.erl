-module(zigzag_conversion).
-export([convert/2]).

convert(_, 1) -> [];
convert(Str, Rows) ->
    Length = erlang:length(Str),
    if
        Rows >= Length -> Str;
        true ->
            Lists = lists:seq(1, Rows),
            lists:foldl(fun(I, Acc) ->
                            Index = I - 1,
                            Row = Index rem (2 * Rows - 2),
                            case Row of
                                0 -> lists:append(Acc, [lists:nth(Index + 1, Str)]);
                                _ ->
                                    case (2 * Rows - 2 - Row) == Row of
                                        true -> lists:append(Acc, [lists:nth(Index + 1, Str)]);
                                        false -> lists:append(Acc, [lists:nth(Index + 1, Str)])
                                    end
                            end
                        end, [], lists:seq(0, Length - 1))
    end.