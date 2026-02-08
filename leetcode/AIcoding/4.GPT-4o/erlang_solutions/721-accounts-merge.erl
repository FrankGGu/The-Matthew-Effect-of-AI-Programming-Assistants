-module(solution).
-export([accounts_merge/1]).

accounts_merge(Accounts) ->
    Graph = build_graph(Accounts),
    Visited = lists:duplicate(length(Accounts), false),
    lists:map(fun(Index) -> 
        case lists:nth(Index + 1, Accounts) of 
            {Name, Emails} -> 
                case dfs(Graph, Emails, Visited, [], Name) of 
                    {Emails, _Visited} -> 
                        [{Name, lists:usort(Emails)}] 
                end 
        end 
    end, lists:seq(0, length(Accounts) - 1)).

build_graph(Accounts) ->
    Graph = maps:new(),
    lists:foreach(fun({_, Emails}) -> 
        lists:foreach(fun(Email) -> 
            Graph1 = maps:update_with(Email, fun(Emails) -> [Emails | Emails] end, [Emails], Graph)
            Graph2 = lists:foldl(fun(OtherEmail, Acc) -> 
                maps:update_with(OtherEmail, fun(Emails) -> [Email | Emails] end, [Email], Acc) 
            end, Graph1, Emails),
            Graph2 
        end, Emails) 
    end, Accounts),
    Graph.

dfs(Graph, [Email | Rest], Visited, Acc, Name) ->
    case maps:get(Email, Graph, []) of 
        [] -> 
            {Acc ++ [Email], Visited}; 
        Neighbors -> 
            Visited1 = lists:map(fun(EmailIndex) -> 
                if 
                    lists:nth(EmailIndex + 1, Visited) =:= false -> 
                        dfs(Graph, [lists:nth(EmailIndex + 1, Neighbors) | Rest], lists:replace(EmailIndex + 1, true, Visited), [Email | Acc], Name);
                    true -> 
                        {Acc, Visited} 
                end 
            end, lists:seq(0, length(Neighbors) - 1)),
            lists:foldl(fun({NewAcc, NewVisited}, {Acc, Vis}) -> 
                {NewAcc, NewVisited} 
            end, {Acc, Visited1}, Visited1).