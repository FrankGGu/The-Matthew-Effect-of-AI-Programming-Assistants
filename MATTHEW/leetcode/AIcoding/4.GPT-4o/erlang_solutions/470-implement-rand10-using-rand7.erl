-module(solution).
-export([rand10/0]).

%% Simulating the rand7() function that generates a random integer from 1 to 7.
rand7() -> random:uniform(7).

%% Implement the rand10() function using rand7().
rand10() ->
    %% We will generate a uniform random number from 1 to 10 using rejection sampling.
    %% First, generate a number between 1 and 49 by combining two rand7() calls.
    Value = (rand7() - 1) * 7 + rand7(), 
    
    %% If the number is in the range 1-40, map it to 1-10.
    %% We reject any number that is 41-49.
    case Value of
        V when V <= 40 -> 1 + (V rem 10);
        _ -> rand10() %% Retry if the value is outside the valid range.
    end.
