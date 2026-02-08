-module(solution).
-export([powerful_integers/2]).

powerful_integers(Start, Finish) ->
    % Generate all powerful numbers up to Finish
    PowerfulList = generate_powerful_list(Finish),

    % Convert list to a set to ensure uniqueness.
    PowerfulSet = sets:from_list(PowerfulList),

    % Count numbers in the set that fall within the [Start, Finish] range
    Count = sets:fold(fun(N, Acc) when N >= Start, N =< Finish -> Acc + 1;
                         (_, Acc) -> Acc
                      end, 0, PowerfulSet),
    Count.

generate_powerful_list(MaxVal) ->
    % Start with P3_val = 1 (which is 3^0)
    generate_powerful_list_recursive(1, MaxVal, []).

generate_powerful_list_recursive(P3_val, MaxVal, AccList) ->
    if P3_val > MaxVal ->
        % If current P3_val alone exceeds MaxVal, no more powerful numbers can be formed
        % by multiplying with powers of 2 (since P2_val starts at 1).
        AccList;
    else
        % For the current P3_val, generate all multiples by powers of 2
        AccListWithP2 = generate_p2_multiples(P3_val, 1, MaxVal, AccList),

        % Calculate the next power of 3.
        % If P3_val > MaxVal div 3, then P3_val * 3 will definitely be > MaxVal.
        % This is an efficient stopping condition for the P3 loop.
        if P3_val > MaxVal div 3 ->
            AccListWithP2; % No more P3 values can be generated without exceeding MaxVal
        else
            NextP3_val = P3_val * 3,
            generate_powerful_list_recursive(NextP3_val, MaxVal, AccListWithP2)
        end
    end.

generate_p2_multiples(P3_fixed_val, CurrentP2_val, MaxVal, AccList) ->
    Product = P3_fixed_val * CurrentP2_val,
    if Product > MaxVal ->
        % If the current product exceeds MaxVal, stop generating further multiples for this P3_fixed_val
        AccList;
    else
        % Add the current powerful number to the accumulator list
        NewAccList = [Product | AccList],

        % Calculate the next power of 2.
        % If CurrentP2_val > MaxVal div (2 * P3_fixed_val), then the next product
        % (P3_fixed_val * CurrentP2_val * 2) will definitely exceed MaxVal.
        % This is an efficient way to stop the P2 loop early.
        if CurrentP2_val > MaxVal div (2 * P3_fixed_val) ->
            NewAccList; % No more P2 values can be generated without exceeding MaxVal
        else
            NextP2_val = CurrentP2_val * 2,
            generate_p2_multiples(P3_fixed_val, NextP2_val, MaxVal, NewAccList)
        end
    end.