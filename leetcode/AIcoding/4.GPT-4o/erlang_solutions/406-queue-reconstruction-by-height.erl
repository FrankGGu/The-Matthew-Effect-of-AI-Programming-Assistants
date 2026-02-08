-module(solution).
-export([reconstruct_queue/1]).

-spec reconstruct_queue([[integer()]]) -> [[integer()]].
reconstruct_queue(People) ->
    Sorted = lists:sort(fun({H1, _}, {H2, _}) when H1 == H2 -> false;
                         ({H1, _}, {H2, _}) when H1 < H2 -> true;
                         ({H1, _}, {H2, _}) -> false end, People),
    reconstruct_queue_sorted(Sorted, []).

-spec reconstruct_queue_sorted([[integer()]], [[integer()]]) -> [[integer()]].
reconstruct_queue_sorted([], Queue) -> Queue;
reconstruct_queue_sorted([{H, K} | Rest], Queue) ->
    reconstruct_queue_sorted(Rest, insert_in_queue(Queue, {H, K}, K)).

-spec insert_in_queue([[integer()]], {integer(), integer()}, integer()) -> [[integer()]].
insert_in_queue([], Person, _) -> [Person];
insert_in_queue([P | Rest], Person, 0) -> [Person, P | Rest];
insert_in_queue([P | Rest], Person, K) -> [P | insert_in_queue(Rest, Person, K - 1)].
