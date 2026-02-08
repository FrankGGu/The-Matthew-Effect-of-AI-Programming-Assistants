-module(solution).
-export([generateParenthesis/1]).

generateParenthesis(N) ->
    generate(0, 0, "", N).

generate(Open, Close, CurrentString, MaxN) ->
    if
        Open == MaxN andalso Close == MaxN ->
            [CurrentString];
        true ->
            Results1 =
                if
                    Open < MaxN ->
                        generate(Open + 1, Close, CurrentString ++ "(", MaxN);
                    true ->
                        []
                end,
            Results2 =
                if
                    Close < Open ->
                        generate(Open, Close + 1, CurrentString ++ ")", MaxN);
                    true ->
                        []
                end,
            Results1 ++ Results2
    end.