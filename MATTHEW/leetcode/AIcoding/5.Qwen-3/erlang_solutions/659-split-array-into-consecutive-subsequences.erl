-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, 0, maps:put(N+1, 0, maps:put(N-1, 0, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, Acc))
                        end;
                    _ ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, 0, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)))
                        end
                end
        end
    end, Map, lists:seq(1, maps:size(Map))).

-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, 0, maps:put(N+1, 0, maps:put(N-1, 0, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, Acc))
                        end;
                    _ ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, 0, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)))
                        end
                end
        end
    end, Map, lists:seq(1, maps:size(Map))).

-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, 0, maps:put(N+1, 0, maps:put(N-1, 0, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, Acc))
                        end;
                    _ ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, 0, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)))
                        end
                end
        end
    end, Map, lists:seq(1, maps:size(Map))).

-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, 0, maps:put(N+1, 0, maps:put(N-1, 0, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, Acc))
                        end;
                    _ ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, 0, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)))
                        end
                end
        end
    end, Map, lists:seq(1, maps:size(Map))).

-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, 0, maps:put(N+1, 0, maps:put(N-1, 0, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, Acc))
                        end;
                    _ ->
                        case maps:get(N+1, Acc, 0) of
                            0 -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, 0, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)));
                            _ -> maps:put(N, maps:get(N, Acc) - 1, maps:put(N+1, maps:get(N+1, Acc) - 1, maps:put(N-1, maps:get(N-1, Acc) - 1, Acc)))
                        end
                end
        end
    end, Map, lists:seq(1, maps:size(Map))).

-module(split_array_into_consecutive_subsequences).
-export([is_possible/1]).

is_possible(Nums) ->
    Map = lists:foldl(fun(N, Acc) -> 
        Count = maps:get(N, Acc, 0),
        maps:put(N, Count + 1, Acc)
    end, #{}, Nums),
    lists:foldl(fun(N, Acc) ->
        case maps:get(N, Acc, 0) of
            0 -> Acc;
            _ ->
                case maps:get(N-1, Acc, 0) of
                    0 ->
                        case maps:get