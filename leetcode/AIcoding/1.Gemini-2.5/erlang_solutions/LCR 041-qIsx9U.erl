-module(moving_average).
-export([init/1, next/2]).

-record(state, {queue :: {list(), list()}, sum :: float(), count :: integer(), max_size :: integer()}).

init(K) ->
    #state{queue = {[], []}, sum = 0.0, count = 0, max_size = K}.

next(Val, #state{queue = {In, Out}, sum = CurrentSum, count = CurrentCount, max_size = MaxSize} = OldState) ->
    NewIn = [Val | In],
    NewSum = CurrentSum + Val,
    NewCount = CurrentCount + 1,

    {FinalQueueIn, FinalQueueOut, FinalSum, FinalCount} =
        if
            NewCount > MaxSize ->
                {OldestVal, {QueueInAfterDequeue, QueueOutAfterDequeue}} = dequeue_element_and_state({NewIn, Out}),
                {QueueInAfterDequeue, QueueOutAfterDequeue, NewSum - OldestVal, NewCount - 1};
            true ->
                {NewIn, Out, NewSum, NewCount}
        end,

    Average = case FinalCount of
                  0 -> 0.0;
                  _ -> FinalSum / FinalCount
              end,

    {Average, OldState#state{queue = {FinalQueueIn, FinalQueueOut}, sum = FinalSum, count = FinalCount}}.

dequeue_element_and_state({In, Out}) ->
    case Out of
        [H|T] ->
            {H, {In, T}};
        [] ->
            ReversedIn = lists:reverse(In),
            {H2|T2} = ReversedIn,
            {H2, {[], T2}}
    end.