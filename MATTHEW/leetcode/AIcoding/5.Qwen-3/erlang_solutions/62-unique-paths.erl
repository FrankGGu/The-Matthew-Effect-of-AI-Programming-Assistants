-module(unique_paths).
-export([unique_paths/2]).

unique_paths(M, N) ->
    unique_paths(M, N, 1, 1, #{}).

unique_paths(M, N, X, Y, Memo) ->
    Key = {X, Y},
    case maps:find(Key, Memo) of
        {ok, Val} -> Val;
        error ->
            if
                X == M andalso Y == N -> 1;
                X > M orelse Y > N -> 0;
                true ->
                    Res = unique_paths(M, N, X + 1, Y, Memo) + unique_paths(M, N, X, Y + 1, Memo),
                    maps:put(Key, Res, Memo)
            end
    end.