-module(block_placement).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Blocks = lists:seq(1, N),
    {ok, [Q]} = io:fread("", "~d"),
    process_queries(Q, Blocks).

process_queries(0, _) -> ok;
process_queries(Q, Blocks) ->
    {ok, [Type, X]} = io:fread("", "~d~d"),
    case Type of
        1 -> 
            NewBlocks = lists:delete(X, Blocks),
            process_queries(Q - 1, NewBlocks);
        2 -> 
            case lists:member(X, Blocks) of
                true -> io:format("1~n");
                false -> io:format("0~n")
            end,
            process_queries(Q - 1, Blocks);
        3 -> 
            case [Y || Y <- Blocks, Y >= X] of
                [] -> io:format("-1~n");
                L -> io:format("~p~n", [lists:min(L)])
            end,
            process_queries(Q - 1, Blocks);
        4 -> 
            case [Y || Y <- Blocks, Y =< X] of
                [] -> io:format("-1~n");
                L -> io:format("~p~n", [lists:max(L)])
            end,
            process_queries(Q - 1, Blocks)
    end.