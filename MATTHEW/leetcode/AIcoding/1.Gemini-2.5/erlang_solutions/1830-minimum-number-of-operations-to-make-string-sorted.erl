-module(solution).
-export([make_string_sorted/1]).

-define(MOD, 1_000_000_007).

pow_mod(_, 0, _, Acc) -> Acc;
pow_mod(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
               true -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    pow_mod(NewBase, Exp div 2, Mod, NewAcc).

inv_mod(N, Mod) ->
    pow_mod(N, Mod - 2, Mod, 1).

precompute_factorials(N, Mod) ->
    Facts = array:new([{size, N + 1}, {fixed, true}, {default, 1}]),
    InvFacts = array:new([{size, N + 1}, {fixed, true}, {default, 1}]),

    % Calculate factorials: Facts[i] = i!
    Facts1 = lists:foldl(fun(I, AccFacts) ->
        FactI = (array:get(I-1, AccFacts) * I) rem Mod,
        array:set(I, FactI, AccFacts)
    end, Facts, lists:seq(1, N)),

    % Calculate inv_fact[N] first using modular inverse
    InvLastFact = inv_mod(array:get(N, Facts1), Mod),
    InvFacts1 = array:set(N, InvLastFact, InvFacts),

    % Calculate other inverse factorials backwards: InvFacts[i] = (i!)^(-1)
    % InvFacts[i] = InvFacts[i+1] * (i+1) % Mod
    InvFacts2 = lists:foldr(fun(I, AccInvFacts) ->
        InvFactI = (array:get(I+1, AccInvFacts) * (I+1)) rem Mod,
        array:set(I, InvFactI, AccInvFacts)
    end, InvFacts1, lists:seq(0, N-1)),
    {Facts1, InvFacts2}.

init_freq(S) ->
    Freq = array:new([{size, 26}, {fixed, true}, {default, 0}]),
    lists:foldl(fun(C, AccFreq) ->
        Idx = C - $a,
        array:set(Idx, array:get(Idx, AccFreq) + 1, AccFreq)
    end, Freq, S).

make_string_sorted(S) ->
    N = length(S),
    {Facts, InvFacts} = precompute_factorials(N, ?MOD),
    InitialFreq = init_freq(S),

    % Fold state: {CurrentAnswer, CurrentFrequencyArray}
    % Iterate through the string from left to right (0-indexed)
    {Ans, _} = lists:foldl(fun(I, {AccAns, AccFreq}) ->
        Char = lists:nth(I + 1, S), % Erlang lists are 1-indexed, I is 0-indexed
        CharVal = Char - $a, % Convert char to 0-25 integer value
        RemainingLength = N - 1 - I, % Number of characters remaining in the suffix

        % Count characters in the current multiset (represented by AccFreq) that are smaller than Char
        NumSmallerChars = lists:foldl(fun(J, Sum) ->
            if J < CharVal -> Sum + array:get(J, AccFreq);
               true -> Sum
            end
        end, 0, lists:seq(0, 25)), % Iterate through all possible char values (0 to 25)

        % Calculate the term for the current position:
        % (NumSmallerChars * (RemainingLength)! ) / (product of factorials of frequencies of remaining chars)
        CurrentTerm = (NumSmallerChars * array:get(RemainingLength, Facts)) rem ?MOD,

        % Calculate the inverse of the product of factorials of frequencies
        DenominatorInv = lists:foldl(fun(J, Prod) ->
            (Prod * array:get(array:get(J, AccFreq), InvFacts)) rem ?MOD
        end, 1, lists:seq(0, 25)),

        TermToAdd = (CurrentTerm * DenominatorInv) rem ?MOD,
        NewAns = (AccAns + TermToAdd) rem ?MOD,

        % Decrement the frequency of the current character for the next iteration
        NewFreq = array:set(CharVal, array:get(CharVal, AccFreq) - 1, AccFreq),
        {NewAns, NewFreq}
    end, {0, InitialFreq}, lists:seq(0, N-1)),
    Ans.