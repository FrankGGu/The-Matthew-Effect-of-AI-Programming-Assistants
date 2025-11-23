-module(solution).
-export([vowel_strings/2]).

vowel_strings(Words, Queries) ->
    % Step 1: Create a list of 0s and 1s indicating if each word is a vowel string.
    VowelIndicators = [
        case is_vowel_string(Word) of
            true -> 1;
            false -> 0
        end
        || Word <- Words
    ],

    % Step 2: Compute prefix sums.
    % The prefix sums list will be [0, P1, P2, ..., Pn], where Pk is the sum of
    % VowelIndicators[0] through VowelIndicators[k-1].
    % This allows O(1) range sum queries: sum(L, R) = PrefixSums[R+1] - PrefixSums[L].
    PrefixSumsList = build_prefix_sums(VowelIndicators),

    % Step 3: Convert the prefix sums list to an array for O(1) indexed access.
    PrefixSumsArray = array:from_list(PrefixSumsList),

    % Step 4: Process each query.
    [array:get(R + 1, PrefixSumsArray) - array:get(L, PrefixSumsArray)
     || [L, R] <- Queries].

is_vowel(C) ->
    C == $a orelse C == $e orelse C == $i orelse C == $o orelse C == $u.

is_vowel_string(S) ->
    is_vowel(hd(S)) andalso is_vowel(lists:last(S)).

build_prefix_sums(Indicators) ->
    build_prefix_sums(Indicators, 0, [0]).

build_prefix_sums([], _CurrentSum, Acc) ->
    lists:reverse(Acc);
build_prefix_sums([H|T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    build_prefix_sums(T, NewSum, [NewSum|Acc]).