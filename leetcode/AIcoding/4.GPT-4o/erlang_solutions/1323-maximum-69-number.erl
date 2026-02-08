-module(solution).
-export([maximum_69_number/1]).

maximum_69_number(N) ->
    List = integer_to_list(N),
    case lists:find(fun(X) -> X == $6 end, List) of
        {ok, Index} -> 
            NewList = lists:replace_at(Index, $9, List),
            list_to_integer(NewList);
        _ -> 
            N
    end.