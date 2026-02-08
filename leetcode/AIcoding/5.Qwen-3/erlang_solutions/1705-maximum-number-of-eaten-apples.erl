-module(max_eaten_apples).
-export([eaten_apples/2]).

eaten_apples(Apples, Days) ->
    % Create a priority queue to track the expiration dates of apples
    {_, Eaten} = lists:foldl(fun({Apple, Day}, {Heap, Count}) ->
        % Add the apple to the heap with its expiration date
        NewHeap = erlang:heappush(Heap, {Day + 1, Apple}),
        % Remove expired apples from the heap
        {ValidHeap, _} = remove_expired(NewHeap, 0),
        % Eat one apple if available
        case ValidHeap of
            [] -> {[], Count};
            _ ->
                {NewHeap2, [ExpDate | _]} = erlang:heappop(ValidHeap),
                {NewHeap2, Count + 1}
        end
    end, {erlang:heap(), 0}, lists:zip(Apples, Days)),
    Eaten.

remove_expired(Heap, CurrentDay) ->
    case Heap of
        [] -> {[], CurrentDay};
        _ ->
            {ExpDate, _} = erlang:heappop(Heap),
            if
                ExpDate > CurrentDay ->
                    % Put back the apple and return
                    {erlang:heappush([], {ExpDate, _}), CurrentDay};
                true ->
                    % Remove expired apple and continue
                    remove_expired(erlang:heappop(Heap), CurrentDay)
            end
    end.