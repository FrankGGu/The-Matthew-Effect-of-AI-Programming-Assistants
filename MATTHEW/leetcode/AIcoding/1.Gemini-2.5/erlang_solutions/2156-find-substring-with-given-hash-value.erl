-module(solution).
-export([sub_with_hash/5]).

sub_with_hash(S, Power, Modulo, K, HashValue) ->
    % Convert the input string to a binary for efficient O(1) character access.
    S_binary = list_to_binary(S),
    N = byte_size(S_binary),

    % Calculate power^(K-1) mod Modulo. This term is used to remove the contribution
    % of the rightmost character when shifting the window to the left.
    % If K=1, then K-1=0, and power^0 = 1.
    PowerKMinus1 = power_mod(Power, K - 1, Modulo),

    % Calculate the hash for the initial rightmost substring of length K.
    % This substring starts at index N-K (0-indexed) and ends at N-1.
    InitialHash = calculate_initial_hash_binary(S_binary, N, K, Power, Modulo),

    % Start iterating from the rightmost possible starting index (N-K) down to 0.
    % The problem asks for the rightmost substring, so we initialize the result
    % with the starting index of the very first hash calculated (N-K).
    % If a matching hash is found, we update the result. Since we iterate right-to-left,
    % the first match found will be the rightmost one.
    find_rightmost_substring_binary(N - K, N, K, Power, Modulo, HashValue, S_binary, PowerKMinus1, InitialHash, N - K).

get_char_val(Binary, Index) ->
    (binary:at(Binary, Index) - $a + 1).

calculate_initial_hash_binary(S_binary, N, K, Power, Modulo) ->
    calculate_initial_hash_acc_binary(S_binary, N, K, Power, Modulo, 0, 0, 1).

calculate_initial_hash_acc_binary(_S_binary, _N, K, _Power, _Modulo, K, CurrentHash, _CurrentPower) ->
    CurrentHash; % Base case: K terms have been summed.
calculate_initial_hash_acc_binary(S_binary, N, K, Power, Modulo, J, CurrentHash, CurrentPower) ->
    % The character at 0-indexed position N-K+J in the original string corresponds to s[J] in the substring.
    CharVal = get_char_val(S_binary, N - K + J),
    NewHash = (CurrentHash + CharVal * CurrentPower) rem Modulo,
    NewPower = (CurrentPower * Power) rem Modulo,
    calculate_initial_hash_acc_binary(S_binary, N, K, Power, Modulo, J + 1, NewHash, NewPower).

find_rightmost_substring_binary(I, _N, _K, _Power, _Modulo, HashValue, _S_binary, _PowerKMinus1, CurrentHash, CurrentResultIndex) when I < 0 ->
    CurrentResultIndex; % Base case: All possible substrings have been checked. Return the result.
find_rightmost_substring_binary(I, N, K, Power, Modulo, HashValue, S_binary, PowerKMinus1, CurrentHash, CurrentResultIndex) ->
    % Update CurrentResultIndex if the hash of the current substring s[I ... I+K-1] matches HashValue.
    NewResultIndex = if CurrentHash == HashValue -> I; true -> CurrentResultIndex end,

    % If I is 0, this is the last iteration, no need to calculate the next hash.
    % The problem guarantees at least one such substring, so NewResultIndex will be valid.
    if I == 0 ->
        NewResultIndex;
    true ->
        % Calculate the hash for the next substring to the left, which starts at I-1: s[I-1 ... I+K-2].
        % Let H_I be CurrentHash (hash of s[I ... I+K-1]). We want to find H_{I-1}.
        % H_I     = val(s[I])*P^0 + val(s[I+1])*P^1 + ... + val(s[I+K-1])*P^(K-1)
        % H_{I-1} = val(s[I-1])*P^0 + val(s[I])*P^1 + ... + val(s[I+K-2])*P^(K-1)

        % Step 1: Isolate the common part X = val(s[I])*P^0 + val(s[I+1])*P^1 + ... + val(s[I+K-2])*P^(K-2).
        % From H_I = X + val(s[I+K-1])*P^(K-1), we can find X:
        % X = H_I - val(s[I+K-1])*P^(K-1) (all modulo Modulo).
        % s[I+K-1] is the character at 0-indexed position I+K-1 in the original string.
        CharValToRemove = get_char_val(S_binary, I + K - 1),
        TermToRemove = (CharValToRemove * PowerKMinus1) rem Modulo,

        % Ensure the result of subtraction is non-negative before modulo.
        X = (CurrentHash - TermToRemove + Modulo) rem Modulo,

        % Step 2: Construct H_{I-1} using X and the new leftmost character val(s[I-1]).
        % H_{I-1} = val(s[I-1])*P^0 + P * X.
        % s[I-1] is the character at 0-indexed position I-1 in the original string.
        CharValToAdd = get_char_val(S_binary, I - 1),

        NextHash = (CharValToAdd + Power * X) rem Modulo,

        % Recurse with the new starting index (I-1) and the newly calculated hash.
        find_rightmost_substring_binary(I - 1, N, K, Power, Modulo, HashValue, S_binary, PowerKMinus1, NextHash, NewResultIndex)
    end.

power_mod(Base, Exp, Mod) ->
    power_mod_acc(Base, Exp, Mod, 1).

power_mod_acc(_Base, 0, _Mod, Acc) -> Acc;
power_mod_acc(Base, Exp, Mod, Acc) ->
    if Exp rem 2 == 1 -> % If exponent is odd
        power_mod_acc((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
    true -> % If exponent is even
        power_mod_acc((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.