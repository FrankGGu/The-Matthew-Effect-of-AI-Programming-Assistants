-module(solution).
-export([strange_printer/1]).

strange_printer(P) ->
    N = length(P),
    Map = maps:from_list([{C, true} || C <- lists:usort(P)]),
    Grid = create_grid(N, Map),
    dp(Grid, N, N, Map).

create_grid(N, Map) ->
    lists:duplicate(N, lists:duplicate(N, false)).

dp(Grid, N, M, Map) ->
    case N of
        0 -> false;
        _ ->
            lists:foldl(fun(I, Acc) ->
                lists:foldl(fun(J, Acc1) ->
                    if
                        Acc1 =:= false -> Acc1;
                        true -> 
                            if
                                I < J -> 
                                    update_grid(Grid, I, J, M, Map);
                                true -> 
                                    Acc1
                            end
                    end
                end, Acc, lists:seq(1, N))
            end, true, lists:seq(1, N)
    end.

update_grid(Grid, I, J, M, Map) ->
    case Map:get(lists:nth(I, Grid)) of
        true -> 
            case Map:get(lists:nth(J, Grid)) of
                true -> true;
                false -> false
            end;
        false -> false
    end.