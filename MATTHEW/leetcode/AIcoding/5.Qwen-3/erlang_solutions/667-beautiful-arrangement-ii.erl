-module(BeautifulArrangementII).
-export([construct_array/2]).

construct_array(N, K) ->
    construct_array(N, K, 1, []).

construct_array(_, 0, _, Acc) ->
    lists:reverse(Acc);
construct_array(N, K, Start, Acc) ->
    construct_array(N, K - 1, Start + 1, [Start | Acc]).

construct_array(N, K, Start, Acc, Direction) ->
    construct_array(N, K - 1, Start + Direction, [Start | Acc]).

construct_array(N, K) ->
    construct_array(N, K, 1, [], 1).