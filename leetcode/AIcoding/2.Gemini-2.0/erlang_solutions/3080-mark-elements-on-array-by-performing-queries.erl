-module(mark_elements).
-export([solve/2]).

solve(N, Queries) ->
    solve(N, Queries, lists:seq(1, N)).

solve(_, [], Acc) ->
    Acc;
solve(N, [Q|T], Acc) ->
    case Q of
        {1, L, R, X} ->
            NewAcc = lists:map(fun(E) ->
                                        case E >= L andalso E <= R of
                                            true ->
                                                case E rem X == 0 of
                                                    true ->
                                                        -1;
                                                    false ->
                                                        E
                                                end;
                                            false ->
                                                E
                                        end
                                end, Acc),
            solve(N, T, NewAcc);
        {2, Y} ->
            case lists:nth(Y, Acc) of
                -1 ->
                    solve(N, T, Acc);
                Val ->
                    NewAcc = lists:map(fun(E) ->
                                                case E == Val of
                                                    true ->
                                                        -1;
                                                    false ->
                                                        E
                                                end
                                        end, Acc),
                    solve(N, T, NewAcc)
            end
    end.