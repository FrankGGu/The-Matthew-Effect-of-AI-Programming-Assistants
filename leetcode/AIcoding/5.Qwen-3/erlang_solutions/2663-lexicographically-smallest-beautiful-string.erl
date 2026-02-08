-module(lexicographically_smallest_beautiful_string).
-export([solve/1]).

solve(N) ->
    solve(N, 0, []).

solve(N, Pos, Acc) when Pos == N ->
    lists:reverse(Acc);
solve(N, Pos, Acc) ->
    Start = case Acc of
                [] -> $a;
                [H | _] -> H + 1
            end,
    case Pos of
        0 -> solve(N, Pos + 1, [Start | Acc]);
        _ ->
            case lists:member(Start, Acc) of
                true -> solve(N, Pos + 1, Acc);
                false ->
                    case Pos > 1 andalso lists:nth(Pos - 1, Acc) == Start of
                        true -> solve(N, Pos + 1, Acc);
                        false -> solve(N, Pos + 1, [Start | Acc])
                    end
            end
    end.