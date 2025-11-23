-module(find_servers).
-export([most_frequent_server/2]).

most_frequent_server(K, Arrival) ->
    Servers = lists:seq(0, K - 1),
    {Result, _} = lists:foldl(
        fun(A, {Acc, Available}) ->
            {Server, NewAvailable} = find_available_server(A, Available, K),
            case Server of
                none ->
                    {Acc, Available};
                _ ->
                    NewAcc = update_acc(Acc, Server),
                    {NewAcc, NewAvailable}
            end
        end,
        {[], Servers},
        Arrival
    ),
    MaxCount = lists:max([element(2, X) || X <- Result]),
    [element(1, X) || X <- Result, element(2, X) == MaxCount].

find_available_server(A, Available, K) ->
    case Available of
        [] ->
            {none, []};
        _ ->
            {Server, Rest} = find_best_server(A, Available, K, hd(Available), tl(Available)),
            {Server, Rest}
    end.

find_best_server(A, Available, K, BestServer, []) ->
    {BestServer, lists:delete(BestServer, Available)};
find_best_server(A, Available, K, BestServer, [H | T]) ->
    case (H rem K) < (BestServer rem K) of
        true ->
            find_best_server(A, Available, K, H, T);
        false ->
            find_best_server(A, Available, K, BestServer, T)
    end.

update_acc(Acc, Server) ->
    case lists:keyfind(Server, 1, Acc) of
        false ->
            [{Server, 1} | Acc];
        {Server, Count} ->
            lists:keyreplace(Server, 1, Acc, {Server, Count + 1})
    end.