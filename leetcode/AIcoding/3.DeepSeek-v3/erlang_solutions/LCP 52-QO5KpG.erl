-module(solution).
-export([count_nodes/2]).

count_nodes(Root, Queries) ->
    T = build_tree(Root),
    lists:map(fun(Query) -> query(T, Query) end, Queries).

build_tree([]) -> [];
build_tree([Val | Rest]) ->
    {Left, Right} = lists:splitwith(fun(X) -> X < Val end, Rest),
    {Val, build_tree(Left), build_tree(Right)}.

query([], _) -> 0;
query({Val, Left, Right}, {Type, X}) ->
    case Type of
        1 -> 
            if Val >= X -> 1 + query(Left, {Type, X}) + query(Right, {Type, X});
               true -> query(Right, {Type, X})
            end;
        2 ->
            if Val =< X -> 1 + query(Left, {Type, X}) + query(Right, {Type, X});
               true -> query(Left, {Type, X})
            end
    end.