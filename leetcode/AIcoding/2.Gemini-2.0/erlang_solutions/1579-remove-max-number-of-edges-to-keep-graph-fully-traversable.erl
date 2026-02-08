-module(remove_max_edges).
-export([max_num_edges_to_remove/2]).

-spec max_num_edges_to_remove(N :: integer(), Edges :: [[integer()]]) -> integer().
max_num_edges_to_remove(N, Edges) ->
    UF1 = uf_init(N),
    UF2 = uf_init(N),
    {Both, UF11, UF22} = process_type_3(Edges, UF1, UF2),
    {Alice, UF111} = process_type_1(Edges, UF11),
    {Bob, UF222} = process_type_2(Edges, UF22),
    if uf_count(UF111) == 1 andalso uf_count(UF222) == 1 then
        length(Edges) - (Both + Alice + Bob)
    else
        -1
    end.

process_type_3(Edges, UF1, UF2) ->
    process_edges(Edges, UF1, UF2, 0, fun(Type, U, V, Acc, UF11, UF22) ->
                                           if Type == 3 then
                                               {R1, UF111} = uf_union(U, V, UF11),
                                               {R2, UF222} = uf_union(U, V, UF22),
                                               if R1 or R2 then
                                                   {Acc + 1, UF111, UF222}
                                               else
                                                   {Acc, UF11, UF22}
                                               end
                                           else
                                               {Acc, UF11, UF22}
                                           end
                                       end).

process_type_1(Edges, UF) ->
    process_edges(Edges, UF, 0, fun(Type, U, V, Acc, UF1) ->
                                     if Type == 1 then
                                         {R, UF11} = uf_union(U, V, UF1),
                                         if R then
                                             {Acc + 1, UF11}
                                         else
                                             {Acc, UF1}
                                         end
                                     else
                                         {Acc, UF1}
                                     end
                                 end).

process_type_2(Edges, UF) ->
    process_edges(Edges, UF, 0, fun(Type, U, V, Acc, UF1) ->
                                     if Type == 2 then
                                         {R, UF11} = uf_union(U, V, UF1),
                                         if R then
                                             {Acc + 1, UF11}
                                         else
                                             {Acc, UF1}
                                         end
                                     else
                                         {Acc, UF1}
                                     end
                                 end).

process_edges([], UF1, UF2, Acc, _) ->
    {Acc, UF1, UF2};
process_edges([], UF, Acc, _) ->
    {Acc, UF};
process_edges([ [Type, U, V] | Rest], UF1, UF2, Acc, Fun) ->
    Fun(Type, U, V, Acc, UF1, UF2, fun(Acc1, UF11, UF22) -> process_edges(Rest, UF11, UF22, Acc1, Fun));
process_edges([ [Type, U, V] | Rest], UF, Acc, Fun) ->
    Fun(Type, U, V, Acc, UF, fun(Acc1, UF11) -> process_edges(Rest, UF11, Acc1, Fun)).

uf_init(N) ->
    {lists:seq(1, N), lists:duplicate(N, 1), N}.

uf_find(X, {Parent, _, _}) ->
    uf_find_internal(X, Parent).

uf_find_internal(X, Parent) ->
    if X == lists:nth(X, Parent) then
        X
    else
        Root = uf_find_internal(lists:nth(X, Parent), Parent),
        lists:nth(X, Parent, Root, Parent)
    end.

uf_union(X, Y, {Parent, Size, Count}) ->
    RootX = uf_find(X, {Parent, Size, Count}),
    RootY = uf_find(Y, {Parent, Size, Count}),
    if RootX == RootY then
        {false, {Parent, Size, Count}}
    else
        SizeX = lists:nth(RootX, Size),
        SizeY = lists:nth(RootY, Size),
        if SizeX < SizeY then
            {Parent1, Size1} = uf_update(Parent, Size, RootX, RootY, SizeX, SizeY),
            {true, {Parent1, Size1, Count - 1}}
        else
            {Parent1, Size1} = uf_update(Parent, Size, RootY, RootX, SizeY, SizeX),
            {true, {Parent1, Size1, Count - 1}}
        end
    end.

uf_update(Parent, Size, RootX, RootY, SizeX, SizeY) ->
    Parent1 = lists:nth(RootX, RootY, Parent),
    Size1 = lists:nth(RootY, SizeX + SizeY, Size),
    {Parent1, Size1}.

uf_count({_, _, Count}) ->
    Count.