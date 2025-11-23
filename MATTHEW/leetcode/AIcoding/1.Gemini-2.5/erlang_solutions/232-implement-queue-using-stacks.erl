-module(my_queue).
-export([new/0, push/2, pop/1, peek/1, empty/1]).

new() ->
    {[], []}.

push(X, {S1, S2}) ->
    {[X|S1], S2}.

pop({S1, S2}) ->
    case S2 of
        [] ->
            %% S2 is empty, move all elements from S1 to S2
            ReversedS1 = lists:reverse(S1),
            [H|T] = ReversedS1, %% Problem constraints guarantee pop is called on non-empty queue
            {H, {[], T}};
        [H|T] ->
            %% S2 is not empty, pop from S2
            {H, {S1, T}}
    end.

peek({S1, S2}) ->
    case S2 of
        [] ->
            %% S2 is empty, move all elements from S1 to S2
            ReversedS1 = lists:reverse(S1),
            [H|_] = ReversedS1, %% Problem constraints guarantee peek is called on non-empty queue
            {H, {[], ReversedS1}}; %% State changes as S1 is moved to S2
        [H|_] ->
            %% S2 is not empty, peek from S2
            {H, {S1, S2}} %% State does not change
    end.

empty({S1, S2}) ->
    S1 == [] andalso S2 == [].