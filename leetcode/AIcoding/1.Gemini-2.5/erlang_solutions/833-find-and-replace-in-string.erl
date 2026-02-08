-module(solution).
-export([findAndReplace/4]).

findAndReplace(S, Indices, Sources, Targets) ->
    % 1. Combine Indices, Sources, Targets into a list of operations.
    Ops = lists:zip3(Indices, Sources, Targets),

    % 2. Filter out operations where the source string does not match the substring in S.
    ValidOps = lists:filter(fun({Idx, Src, _Trg}) -> is_match(S, Idx, Src) end, Ops),

    % 3. Sort valid operations by index in descending order.
    % This ensures that replacements are applied from right to left,
    % preventing earlier replacements from affecting the indices of later ones.
    SortedValidOps = lists:sort(fun({I1,_,_}, {I2,_,_}) -> I1 > I2 end, ValidOps),

    % 4. Apply replacements using foldl, starting with the original string S.
    lists:foldl(fun({Idx, Src, Trg}, AccS) -> apply_replace(AccS, Idx, Src, Trg) end, S, SortedValidOps).

is_match(S, Index, Source) ->
    SourceLen = length(Source),
    StringLen = length(S),
    if
        % Check if the source string would go out of bounds of S
        Index + SourceLen > StringLen -> false;
        true ->
            % Extract the substring from S (1-based index for lists:sublist)
            Substring = lists:sublist(S, Index + 1, SourceLen),
            Substring == Source
    end.

apply_replace(S, Index, Source, Target) ->
    SourceLen = length(Source),
    % Get the prefix of S before the replacement point.
    % Index is 0-based, lists:sublist is 1-based.
    Prefix = lists:sublist(S, 1, Index),
    % Get the suffix of S after the replaced part.
    % Index + SourceLen is the end of the replaced part (0-based).
    % Index + SourceLen + 1 is the start of the suffix (1-based).
    Suffix = lists:nthtail(Index + SourceLen + 1, S),
    % Concatenate Prefix, Target, and Suffix to form the new string.
    Prefix ++ Target ++ Suffix.