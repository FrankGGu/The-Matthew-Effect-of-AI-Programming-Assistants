-module(soup_servings).
-export([soupServings/1]).

soupServings(N) ->
    case N of
        0 -> 0.5;
        _ ->
            N_prime = erlang:ceil(N / 25),
            %% If N_prime is sufficiently large, the probability converges to 0.5.
            %% The common threshold for N is 4800, which means N_prime = 192.
            %% So, if N_prime > 192, we can return 0.5.
            if N_prime > 192 ->
                0.5;
            true ->
                {Prob, _FinalMemo} = solve(N_prime, N_prime, maps:new()),
                Prob
            end
    end.

solve(A_cups, B_cups, Memo) ->
    %% Base cases
    if A_cups =< 0 andalso B_cups =< 0 ->
        {0.5, Memo};
    A_cups =< 0 -> %% A runs out first
        {1.0, Memo};
    B_cups =< 0 -> %% B runs out first (A doesn't finish first)
        {0.0, Memo};
    true ->
        %% Check memoization
        Key = {A_cups, B_cups},
        case maps:find(Key, Memo) of
            {ok, Value} ->
                {Value, Memo};
            error ->
                %% Recursive step
                %% 0.25 * (P(A-100, B) + P(A-75, B-25) + P(A-50, B-50) + P(A-25, B-75))
                %% In terms of cups (25ml units):
                %% 0.25 * (P(A_cups-4, B_cups) + P(A_cups-3, B_cups-1) + P(A_cups-2, B_cups-2) + P(A_cups-1, B_cups-3))

                {P1, Memo1} = solve(A_cups - 4, B_cups, Memo),
                {P2, Memo2} = solve(A_cups - 3, B_cups - 1, Memo1),
                {P3, Memo3} = solve(A_cups - 2, B_cups - 2, Memo2),
                {P4, Memo4} = solve(A_cups - 1, B_cups - 3, Memo3),

                Prob = 0.25 * (P1 + P2 + P3 + P4),

                %% Store in memo and return
                NewMemo = maps:put(Key, Prob, Memo4),
                {Prob, NewMemo}
        end
    end.