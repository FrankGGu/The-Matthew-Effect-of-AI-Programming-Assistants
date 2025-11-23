-module(solution).
-export([minimal_string/1]).

minimal_string(Operations) ->
    List = lists:foldl(fun(Op, Acc) -> [Op | Acc] end, [], Operations),
    lists:foldl(fun(Op, Acc) -> 
        case Op of
            {append, A, B} -> 
                case lists:member(A, Acc) of
                    true -> 
                        case lists:member(B, Acc) of
                            true -> Acc;
                            false -> lists:keepsort([B | Acc])
                        end;
                    false -> 
                        case lists:member(B, Acc) of
                            true -> lists:keepsort([A | Acc]);
                            false -> lists:keepsort([A, B | Acc])
                        end
                end;
            {prepend, A, B} -> 
                case lists:member(A, Acc) of
                    true -> 
                        case lists:member(B, Acc) of
                            true -> Acc;
                            false -> lists:keepsort([B | Acc])
                        end;
                    false -> 
                        case lists:member(B, Acc) of
                            true -> lists:keepsort([A | Acc]);
                            false -> lists:keepsort([A, B | Acc])
                        end
                end
        end
    end, [], List).