-module(longest_path_different_adjacent).
-export([longest_path/2]).

longest_path(Parent, S) ->
    N = length(S),
    Graph = lists:foldl(fun(I, Acc) ->
                                  case lists:nth(I + 1, Parent) of
                                      0 -> Acc;
                                      P ->
                                          P0 = P - 1,
                                          Acc#{P0 => [I|maps:get(P0, Acc, [])],
                                                I => [P0|maps:get(I, Acc, [])]}
                                  end
                              end, #{}, lists:seq(1, N - 1)),
    {_, Result} = dfs(0, Graph, S, #{}, 0),
    Result.

dfs(Node, Graph, S, Visited, CurrentMax) ->
    Visited1 = Visited#{Node => true},
    Children = maps:get(Node, Graph, []),
    {NewVisited, MaxLengths} = lists:foldl(fun(Child, {VAcc, LAcc}) ->
                                                 case maps:get(Child, VAcc, false) of
                                                     true -> {VAcc, LAcc};
                                                     false ->
                                                         case lists:nth(Child + 1, S) =:= lists:nth(Node + 1, S) of
                                                             true -> {VAcc, LAcc};
                                                             false ->
                                                                 {NV, Length} = dfs(Child, Graph, S, VAcc, CurrentMax),
                                                                 {NV, [Length|LAcc]}
                                                         end
                                                 end
                                             end, {Visited1, []}, Children),

    SortedLengths = lists:sort(lists:reverse(MaxLengths)),
    case SortedLengths of
        [L1, L2|_] ->
            Length = 1 + L1 + L2;
            {NewVisited, max(CurrentMax, Length)};
        [L1] ->
            Length = 1 + L1;
            {NewVisited, max(CurrentMax, Length)};
        [] ->
            {NewVisited, max(CurrentMax, 1)}
    end.