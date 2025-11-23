-module(solution).
-export([generateParenthesis/1]).

generateParenthesis(N) ->
    generate(N, N, []).

generate(0, 0, CurrentList) ->
    [lists:reverse(CurrentList)];
generate(Open, Close, CurrentList) ->
    Results1 = if Open > 0 ->
                   generate(Open - 1, Close, [$( | CurrentList])
               else
                   []
               end,
    Results2 = if Close > 0 andalso Close > Open ->
                   generate(Open, Close - 1, [$) | CurrentList])
               else
                   []
               end,
    Results1 ++ Results2.