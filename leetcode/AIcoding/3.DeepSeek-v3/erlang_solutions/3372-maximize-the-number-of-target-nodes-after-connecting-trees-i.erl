-module(solution).
-export([max_num_target_nodes/2]).

max_num_target_nodes(Trees, Target) ->
    lists:max([count_nodes(Tree, Target) || Tree <- Trees]).

count_nodes(Tree, Target) ->
    case Tree of
        [] -> 0;
        [Val | Children] ->
            Count = if Val == Target -> 1; true -> 0 end,
            Count + lists:sum([count_nodes(Child, Target) || Child <- Children])
    end.