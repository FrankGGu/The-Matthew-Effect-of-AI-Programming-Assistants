-module(visit_array_positions).
-export([maximum_score/3]).

maximum_score(Nums, X, Start) ->
    maximum_score(Nums, X, Start, 0, {}).

maximum_score([], _, _, Acc, _) ->
    Acc;
maximum_score([H|T], X, Start, Acc, Memo) ->
    Key = {length(T), Start}.
    case maps:is_key(Key, Memo) of
        true ->
            maps:get(Key, Memo);
        false ->
            Score1 = case H rem 2 == Start rem 2 of
                         true ->
                             maximum_score(T, X, H rem 2, Acc + H, maps:put(Key, Acc + H, Memo));
                         false ->
                             maximum_score(T, X, H rem 2, Acc + H - X, maps:put(Key, Acc + H - X, Memo))
                     end,
            Score2 = maximum_score(T, X, Start, Acc, Memo),
            MaxScore = max(Score1, Score2),
            maps:put(Key, MaxScore, Memo),
            MaxScore
    end.