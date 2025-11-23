-module(solution).
-export([num_ways/2]).

num_ways(Words, Target) ->
    Count = lists:foldl(fun(W, Acc) -> count_chars(W, Acc) end, #{}, Words),
    NumWays = dfs(Count, Target, 0, 0, #{}),
    NumWays rem (10^9 + 7).

count_chars([], Acc) -> Acc;
count_chars([C | T], Acc) ->
    NewAcc = case maps:get(C, Acc, 0) of
        V when is_integer(V) -> maps:put(C, V + 1, Acc);
        _ -> maps:put(C, 1, Acc)
    end,
    count_chars(T, NewAcc).

dfs(_, [], _, _, _) -> 1;
dfs(Count, Target, Pos, Depth, Memo) ->
    Key = {Pos, Depth},
    case maps:get(Key, Memo, undefined) of
        Val when is_integer(Val) -> Val;
        _ ->
            case Pos >= length(Target) of
                true -> 0;
                false ->
                    Char = lists:nth(Pos + 1, Target),
                    Total = lists:foldl(fun({C, N}, Acc) ->
                        if C == Char ->
                            Case = case Depth + 1 <= length(Words) of
                                true -> dfs(Count, Target, Pos + 1, Depth + 1, Memo);
                                false -> 0
                            end,
                            Acc + (N * Case);
                        true -> Acc
                    end, 0, maps:to_list(Count)),
                    NewMemo = maps:put(Key, Total, Memo),
                    Total rem (10^9 + 7)
            end
    end.

words_length(Words) -> length(Words).