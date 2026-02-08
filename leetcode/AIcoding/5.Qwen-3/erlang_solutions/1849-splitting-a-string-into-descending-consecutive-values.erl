-module(solution).
-export([split_string/1]).

split_string(S) ->
    split_string(S, 0, []).

split_string(_, _, _) when length([]) > 100 -> false;
split_string(S, Start, Acc) ->
    case S of
        [] -> lists:all(fun({A, B}) -> B =:= A + 1 end, lists:zip(lists:tl(Acc), Acc));
        _ ->
            MaxLen = min(10, length(S)),
            lists:foldl(fun(Len, Acc2) ->
                            if
                                Len > 0 ->
                                    NumStr = string:substr(S, 1, Len),
                                    case catch list_to_integer(NumStr) of
                                        {'EXIT', _} -> Acc2;
                                        N ->
                                            case Acc2 of
                                                [] -> split_string(string:substr(S, Len+1), Start + Len, [N]);
                                                [Prev | _] when N == Prev - 1 ->
                                                    split_string(string:substr(S, Len+1), Start + Len, [N | Acc2]);
                                                _ -> Acc2
                                            end;
                                        true -> Acc2
                                    end;
                                true -> Acc2
                            end
                        end, [], lists:seq(1, MaxLen)).