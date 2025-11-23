-module(solution).
-export([execute_instructions/3]).

execute_instructions(N, [StartR, StartC], S) ->
    solve_suffixes_recursive(N, StartR, StartC, S, []).

solve_suffixes_recursive(N, StartR, StartC, [], Acc) ->
    lists:reverse(Acc);
solve_suffixes_recursive(N, StartR, StartC, CurrentSuffix, Acc) ->
    Count = simulate_one_suffix(N, StartR, StartC, CurrentSuffix),
    solve_suffixes_recursive(N, StartR, StartC, tl(CurrentSuffix), [Count | Acc]).

simulate_one_suffix(N, StartR, StartC, Instructions) ->
    simulate_one_suffix_helper(N, StartR, StartC, Instructions, 0).

simulate_one_suffix_helper(N, R, C, [], Count) ->
    Count;
simulate_one_suffix_helper(N, R, C, [Instruction | Rest], Count) ->
    {NewR, NewC} = move(R, C, Instruction),
    if
        NewR >= 0 andalso NewR < N andalso NewC >= 0 andalso NewC < N ->
            simulate_one_suffix_helper(N, NewR, NewC, Rest, Count + 1);
        true ->
            Count
    end.

move(R, C, $L) -> {R, C - 1};
move(R, C, $R) -> {R, C + 1};
move(R, C, $U) -> {R - 1, C};
move(R, C, $D) -> {R + 1, C}.