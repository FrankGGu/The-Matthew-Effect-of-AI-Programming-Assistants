-module(closest_equal_element_queries).
-export([closest_equal/3]).

closest_equal(N, A, Queries) ->
    MaxVal = lists:max(A),
    Map = lists:foldl(fun (X, Acc) ->
        lists:foldl(fun (Y, Acc1) ->
            case lists:keyfind(Y, 1, Acc1) of
                false -> [{Y, [X]} | Acc1];
                {Y, Z} -> [{Y, [X | Z]} | lists:keydelete(Y, 1, Acc1)]
            end
        end, Acc, lists:seq(1, MaxVal))
    end, [], A),
    lists:map(fun(Query) -> 
        case lists:keyfind(Query, 1, Map) of
            false -> -1;
            {_, Indices} -> 
                case lists:sort(Indices) of
                    [I] -> I;
                    [I1, I2 | _] -> if 
                        I1 < I2 -> I1; 
                        true -> I2 
                    end 
                end 
        end 
    end, Queries).