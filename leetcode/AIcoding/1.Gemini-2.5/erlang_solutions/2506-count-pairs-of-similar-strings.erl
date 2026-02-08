-module(solution).
-export([similar_pairs/1]).

similar_pairs(Words) ->
    % Step 1: Generate a unique, sorted list of character codes for each word.
    % This serves as the "signature" for similarity.
    Signatures = [lists:usort(binary_to_list(Word)) || Word <- Words],

    % Step 2: Count the occurrences of each unique signature.
    % We use a map where keys are signatures and values are their counts.
    SignatureCounts = lists:foldl(
        fun(Signature, AccMap) ->
            maps:update_with(Signature, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        Signatures
    ),

    % Step 3: Calculate the total number of pairs.
    % For each signature that appears 'N' times, it contributes N * (N - 1) / 2 pairs.
    lists:foldl(
        fun(Count, TotalPairs) ->
            TotalPairs + (Count * (Count - 1) div 2)
        end,
        0,
        maps:values(SignatureCounts)
    ).