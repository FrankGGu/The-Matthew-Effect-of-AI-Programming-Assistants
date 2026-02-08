-module(rabbits_in_forest).
-export([num_rabbits/1]).

num_rabbits(Answers) ->
    num_rabbits_helper(Answers, []).

num_rabbits_helper([], Acc) ->
    lists:sum([V * (K + 1) || {K, V} <- Acc]).

num_rabbits_helper([H | T], Acc) ->
    case lists:keyfind(H, 1, Acc) of
        false ->
            num_rabbits_helper(T, [{H, 1} | Acc]);
        {H, V} ->
            num_rabbits_helper(T, lists:keyreplace(H, 1, Acc, {H, V + 1}))
    end.