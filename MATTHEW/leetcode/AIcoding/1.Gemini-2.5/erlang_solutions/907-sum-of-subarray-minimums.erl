-module(solution).
-export([sumSubarrayMins/1]).

-include_lib("stdlib/include/array.hrl").

sumSubarrayMins(A) ->
    N = length(A),
    Arr = array:from_list(A),
    Mod = 1000000007,

    PLE = calculate_ple(0, [], array:new(N), N, Arr),
    NLE = calculate_nle(N - 1, [], array:new(N), N, Arr),

    sum_contributions(0, 0, N, Arr, PLE, NLE, Mod).

calculate_ple(Index, Stack, CurrentPLEs, N, Arr) when Index < N ->
    Val = array:get(Index, Arr),
    {NewStack, PrevLessIndex} = pop_stack_ple(Stack, Val, Arr),
    NewPLEs = array:set(Index, PrevLessIndex, CurrentPLEs),
    calculate_ple(Index + 1, [Index | NewStack], NewPLEs, N, Arr);
calculate_ple(_Index, _Stack, CurrentPLEs, _N, _Arr) ->
    CurrentPLEs.

pop_stack_ple([], _Val, _Arr) ->
    {[], -1};
pop_stack_ple([TopIndex | RestStack], Val, Arr) ->
    TopVal = array:get(TopIndex, Arr),
    if
        TopVal >= Val ->
            pop_stack_ple(RestStack, Val, Arr);
        true ->
            {[TopIndex | RestStack], TopIndex}
    end.

calculate_nle(Index, Stack, CurrentNLEs, N, Arr) when Index >= 0 ->
    Val = array:get(Index, Arr),
    {NewStack, NextLessIndex} = pop_stack_nle(Stack, Val, Arr, N),
    NewNLEs = array:set(Index, NextLessIndex, CurrentNLEs),
    calculate_nle(Index - 1, [Index | NewStack], NewNLEs, N, Arr);
calculate_nle(_Index, _Stack, CurrentNLEs, _N, _Arr) ->
    CurrentNLEs.

pop_stack_nle([], _Val, _Arr, N) ->
    {[], N};
pop_stack_nle([TopIndex | RestStack], Val, Arr, N) ->
    TopVal = array:get(TopIndex, Arr),
    if
        TopVal > Val ->
            pop_stack_nle(RestStack, Val, Arr, N);
        true ->
            {[TopIndex | RestStack], TopIndex}
    end.

sum_contributions(Index, TotalSum, N, Arr, PLE, NLE, Mod) when Index < N ->
    Val = array:get(Index, Arr),
    PleVal = array:get(Index, PLE),
    NleVal = array:get(Index, NLE),

    LeftCount = Index - PleVal,
    RightCount = NleVal - Index,

    Contribution = (Val * LeftCount) rem Mod,
    Contribution2 = (Contribution * RightCount) rem Mod,

    NewTotalSum = (TotalSum + Contribution2) rem Mod,
    sum_contributions(Index + 1, NewTotalSum, N, Arr, PLE, NLE, Mod);
sum_contributions(_Index, TotalSum, _N, _Arr, _PLE, _NLE, _Mod) ->
    TotalSum.