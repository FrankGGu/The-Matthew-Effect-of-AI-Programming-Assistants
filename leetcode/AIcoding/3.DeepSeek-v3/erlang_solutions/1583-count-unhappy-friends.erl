-module(solution).
-export([unhappyFriends/4]).

unhappyFriends(N, Preferences, Pairs, Unhappy) ->
    PairMap = create_pair_map(Pairs),
    unhappy_count(N, Preferences, PairMap, 0).

create_pair_map(Pairs) ->
    lists:foldl(fun([X, Y], Acc) -> 
                    maps:put(X, Y, maps:put(Y, X, Acc)) 
                end, #{}, Pairs).

unhappy_count(N, Preferences, PairMap, Count) ->
    lists:foldl(fun(X, Acc) ->
                    CurrentPair = maps:get(X, PairMap),
                    PrefList = lists:nth(X + 1, Preferences),
                    case is_unhappy(X, CurrentPair, PrefList, Preferences, PairMap) of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end, Count, lists:seq(0, N - 1)).

is_unhappy(X, CurrentPair, PrefList, Preferences, PairMap) ->
    Index = index_of(CurrentPair, PrefList),
    lists:any(fun(U) ->
                 Y = maps:get(U, PairMap),
                 UIndex = index_of(U, PrefList),
                 YIndex = index_of(Y, lists:nth(U + 1, Preferences)),
                 XIndex = index_of(X, lists:nth(U + 1, Preferences)),
                 UIndex < Index andalso XIndex < YIndex
              end, lists:sublist(PrefList, Index)).

index_of(Value, List) ->
    {ok, Index} = find_index(Value, List, 0),
    Index.

find_index(Value, [Value | _], Index) -> {ok, Index};
find_index(Value, [_ | T], Index) -> find_index(Value, T, Index + 1);
find_index(_, [], _) -> error.