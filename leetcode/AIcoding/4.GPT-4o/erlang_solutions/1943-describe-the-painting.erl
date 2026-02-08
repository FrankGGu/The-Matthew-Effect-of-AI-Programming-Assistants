-module(solution).
-export([describe_painting/1]).

describe_painting(P) ->
    case P of
        [] -> "";
        _ ->
            lists:foldl(fun(X, Acc) ->
                case Acc of
                    [] -> [X];
                    _ ->
                        Last = lists:last(Acc),
                        if
                            Last == X -> Acc;
                            true -> Acc ++ [X]
                        end
                end
            end, [], P)
            |> lists:map(fun(X) -> integer_to_list(length(lists:filter(fun(Y) -> Y == X end, P))) ++ " " ++ integer_to_list(X) end)
            |> lists:join(" ")
    end.