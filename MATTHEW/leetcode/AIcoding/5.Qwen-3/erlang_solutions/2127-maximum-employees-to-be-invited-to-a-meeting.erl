-module(max_employees_to_be_invited).
-export([max_invitations/1]).

max_invitations(Reports) ->
    N = length(Reports),
    Visited = array:new(N, {default, false}),
    Result = 0,
    Fun = fun(I) ->
        case array:get(I, Visited) of
            false ->
                case dfs(I, Reports, Visited, []) of
                    {cycle, Length} -> Result + Length;
                    _ -> Result
                end;
            _ -> Result
        end
    end,
    lists:foldl(Fun, 0, lists:seq(0, N-1)).

dfs(Node, Reports, Visited, Path) ->
    case array:get(Node, Visited) of
        true ->
            case lists:member(Node, Path) of
                true ->
                    Index = lists:index_of(Node, Path),
                    Length = length(Path) - Index,
                    {cycle, Length};
                false ->
                    {no_cycle, 0}
            end;
        false ->
            array:set(Node, true, Visited),
            NextNode = lists:nth(Node+1, Reports),
            case dfs(NextNode, Reports, Visited, [Node | Path]) of
                {cycle, L} -> {cycle, L};
                {no_cycle, L} -> {no_cycle, L}
            end
    end.