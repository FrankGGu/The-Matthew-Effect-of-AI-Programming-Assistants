-module(solution).
-export([reconstruct_queue/1]).

-spec reconstruct_queue(People :: [[integer(), integer()]]) -> [[integer(), integer()]].
reconstruct_queue(People) ->
    SortedPeople = lists:sort(fun([H1, K1], [H2, K2]) ->
                                      if H1 =:= H2 -> K1 < K2;
                                         true -> H1 > H2
                                      end
                              end, People),

    lists:foldl(fun(Person, Acc) ->
                        K = element(2, Person),
                        insert_at_index(Person, K, Acc)
                end, [], SortedPeople).

insert_at_index(Element, 0, List) ->
    [Element | List];
insert_at_index(Element, Index, [H | T]) when Index > 0 ->
    [H | insert_at_index(Element, Index - 1, T)].