-module(median_finder).
-export([new/0, add_num/2, find_median/1]).

-record(state, {small = [], large = []}).

new() ->
    #state{}.

add_num(Num, State) ->
    {Small, Large} = {State#state.small, State#state.large},
    case {lists:len(Small), lists:len(Large)} of
        {N, N} ->
            if Num < -lists:nth(1, Small) then
                {lists:sort([Num | Small]), Large}
            else
                {Small, lists:sort([Num | Large])}
            end;
        {N, M} when N > M ->
            if Num < -lists:nth(1, Small) then
                {lists:sort(lists:sublist([Num | Small], N)), lists:sort([-(lists:nth(1, Small)) | Large])}
            else
                {lists:sort([Num | Small]), lists:sort([lists:nth(1, Large) | Large])}
            end;
        {N, M} when N < M ->
            if Num > lists:nth(1, Large) then
                {Small, lists:sort([Num | Large])}
            else
                {lists:sort([Num | Small]), lists:sort([lists:nth(1, Large) | Large])}
            end
    end.

find_median(State) ->
    {Small, Large} = {State#state.small, State#state.large},
    case {lists:len(Small), lists:len(Large)} of
        {N, N} ->
            ((-lists:nth(1, Small)) + lists:nth(1, Large)) / 2;
        {N, M} when N > M ->
            -lists:nth(1, Small);
        {N, M} when N < M ->
            lists:nth(1, Large)
    end.

add_num(Num, #state{small = Small, large = Large}) ->
    {NewSmall, NewLarge} = add_num(Num, {Small, Large}),
    #state{small = lists:sort([ -X || X <- NewSmall]), large = lists:sort(NewLarge)}.