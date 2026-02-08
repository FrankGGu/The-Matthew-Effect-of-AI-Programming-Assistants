-module(solution).
-export([longest_common_prefix_k_strings_after_removal/1]).

longest_common_prefix_k_strings_after_removal(Strings) ->
    case Strings of
        [] -> 0; % No strings, LCP is 0
        _ ->
            MinLen = lists:min([length(S) || S <- Strings]),
            MaxPossibleL = MinLen + 1, % Max length of LCP can be MinLen + 1 (e.g., if shortest string is "abc", LCP could be "ab" from "axb", length 2, or "abc" from "axbc", length 3)
            binary_search(0, MaxPossibleL, Strings)
    end.

binary_search(Low, High, Strings) ->
    if Low > High ->
        High; % High is the largest L for which check(L) was true
    else
        Mid = Low + (High - Low) div 2,
        if check(Mid, Strings) ->
            binary_search(Mid + 1, High, Strings); % Try for a longer LCP
        else
            binary_search(Low, Mid - 1, Strings)  % LCP of length Mid not possible, try shorter
        end
    end.

check(L, Strings) ->
    % LCP of length 0 is always possible (empty string)
    if L == 0 -> true;
    else
        % Strings is guaranteed non-empty here due to initial check in longest_common_prefix_k_strings_after_removal
        S0 = hd(Strings),

        Candidates0 = generate_candidates(S0, L),

        % Check if any of these candidates can be formed as a prefix from all strings
        lists:any(fun(P) ->
            lists:all(fun(S) -> can_form_prefix(P, S) end, Strings)
        end, Candidates0)
    end.

generate_candidates(S, L) ->
    LenS = length(S),
    if LenS == L ->
        [S]; % S itself is the only candidate (0 removals)
    else if LenS == L + 1 ->
        % Generate S with one char removed at each position
        lists:foldl(fun(Idx, Acc) ->
            Prefix = lists:sublist(S, 1, Idx-1),
            Suffix = lists:sublist(S, Idx+1, LenS - Idx),
            [Prefix ++ Suffix | Acc]
        end, [], lists:seq(1, LenS));
    else % LenS < L or LenS > L + 1
        []; % Cannot form a prefix of length L with at most one removal
    end end.

can_form_prefix(P, S) ->
    can_form_prefix_impl(P, S, 0).

can_form_prefix_impl([], _S, _RemovedCount) ->
    true; % P is fully matched
can_form_prefix_impl(_P, [], _RemovedCount) ->
    false; % P is not empty, S is empty, P cannot be fully matched
can_form_prefix_impl([Hp|Tp], [Hs|Ts], RemovedCount) ->
    if Hp == Hs ->
        can_form_prefix_impl(Tp, Ts, RemovedCount);
    else ->
        if RemovedCount >= 1 ->
            false; % Already removed one, cannot remove more
        else
            can_form_prefix_impl([Hp|Tp], Ts, RemovedCount + 1) % Skip Hs, increment removed count
        end
    end.