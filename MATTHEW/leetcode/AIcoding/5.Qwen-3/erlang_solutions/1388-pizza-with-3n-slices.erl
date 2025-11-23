-module(pizza_with_3n_slices).
-export([max_score/1]).

max_score(Slices) ->
    N = length(Slices),
    max_score(Slices, 0, N - 1, 1, #{}).

max_score(_, Start, End, K, Memo) when Start > End ->
    0;
max_score(Slices, Start, End, K, Memo) ->
    Key = {Start, End, K},
    case maps:find(Key, Memo) of
        {ok, Val} -> Val;
        error ->
            if
                K == 1 ->
                    lists:sum(lists:sublist(Slices, Start + 1, End - Start));
                true ->
                    Max = lists:max([
                        lists:nth(Start + 1, Slices) + max_score(Slices, Start + 1, End, K - 1, Memo),
                        lists:nth(End + 1, Slices) + max_score(Slices, Start, End - 1, K - 1, Memo)
                    ]),
                    NewMemo = maps:put(Key, Max, Memo),
                    Max
            end
    end.