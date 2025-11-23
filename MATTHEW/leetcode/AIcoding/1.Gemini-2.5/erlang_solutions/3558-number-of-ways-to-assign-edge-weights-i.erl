-module(solution).
-export([number_of_ways_to_assign_edge_weights/2]).

find_and_compress(Node, Parents) ->
    Parent = maps:get(Node, Parents),
    if Parent == Node -> {Node, Parents};
       true ->
           {Root, NewParents} = find_and_compress(Parent, Parents),
           {Root, maps:put(Node, Root, NewParents)}
    end.

pow(Base, Exp) ->
    pow_acc(Base, Exp, 1).

pow_acc(_Base, 0, Acc) -> Acc;
pow_acc(Base, Exp, Acc) ->
    if Exp rem 2 == 1 -> pow_acc(Base * Base, Exp div 2, Acc * Base);
       true -> pow_acc(Base * Base, Exp div 2, Acc)
    end.

number_of_ways_to_assign_edge_weights(N, Edges) ->
    InitialParents = maps:from_list([{I, I} || I <- lists:seq(1, N)]),

    NumEdges = length(Edges),

    {HasCycle, _FinalParents} = lists:foldl(
        fun([U, V], {AccHasCycle, CurrentParents}) ->
            if AccHasCycle == true -> 
                {true, CurrentParents};
               true ->
                   {RootU, ParentsAfterU} = find_and_compress(U, CurrentParents),
                   {RootV, ParentsAfterV} = find_and_compress(V, ParentsAfterU),

                   if RootU == RootV -> 
                       {true, ParentsAfterV};
                      true -> 
                          {false, maps:put(RootU, RootV, ParentsAfterV)}
                   end
            end
        end,
        {false, InitialParents},
        Edges
    ),

    if HasCycle == true -> 0;
       true -> pow(6, NumEdges)
    end.