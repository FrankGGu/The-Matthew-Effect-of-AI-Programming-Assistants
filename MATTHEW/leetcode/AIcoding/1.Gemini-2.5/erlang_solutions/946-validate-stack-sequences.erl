-module(solution).
-export([is_valid_sequence/2]).

is_valid_sequence(Pushed, Popped) ->
    simulate(Pushed, Popped, []).

simulate([], PoppedRemaining, Stack) ->
    Stack == [] andalso PoppedRemaining == [].

simulate([PushHead | PushTail], PoppedRemaining, Stack) ->
    NewStack = [PushHead | Stack],
    pop_until_mismatch(PushTail, PoppedRemaining, NewStack).

pop_until_mismatch(PushTail, [PoppedHead | PoppedTail], [StackHead | StackTail]) when PoppedHead == StackHead ->
    pop_until_mismatch(PushTail, PoppedTail, StackTail);
pop_until_mismatch(PushTail, PoppedRemaining, Stack) ->
    simulate(PushTail, PoppedRemaining, Stack).