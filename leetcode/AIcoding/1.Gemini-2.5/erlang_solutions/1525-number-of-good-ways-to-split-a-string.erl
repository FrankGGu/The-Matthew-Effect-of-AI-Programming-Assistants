-module(solution).
-export([numGoodSplits/1]).

numGoodSplits(S) ->
    Len = length(S),
    % A string must be split into two NON-EMPTY substrings.
    % This requires the string length to be at least 2.
    if Len < 2 -> 0;
       true ->
            % PrefixCounts[i] stores the number of distinct characters in S[0...i]
            PrefixCounts = build_prefix_counts(S),
            % SuffixCounts[i] stores the number of distinct characters in S[i...Len-1]
            SuffixCounts = build_suffix_counts(S),

            % We need to find splits at index 'i' (0-indexed),
            % such that S[0...i] and S[i+1...Len-1] have equal distinct characters.
            % 'i' ranges from 0 to Len-2.
            %
            % The distinct count for S[0...i] is PrefixCounts[i].
            % The distinct count for S[i+1...Len-1] is SuffixCounts[i+1].

            % To efficiently compare these, we create two lists:
            % 1. LeftCounts: [PrefixCounts[0], PrefixCounts[1], ..., PrefixCounts[Len-2]]
            % 2. RightCounts: [SuffixCounts[1], SuffixCounts[2], ..., SuffixCounts[Len-1]]

            % lists:sublist(List, Start, Length) is 1-indexed.
            LeftCounts = lists:sublist(PrefixCounts, 1, Len - 1),
            RightCounts = lists:sublist(SuffixCounts, 2, Len - 1),

            % Zip them to get pairs (PrefixCounts[i], SuffixCounts[i+1])
            Pairs = lists:zip(LeftCounts, RightCounts),

            % Count how many pairs have equal elements
            lists:foldl(fun({L, R}, Acc) ->
                                if L == R -> Acc + 1;
                                   true -> Acc
                                end
                        end, 0, Pairs)
    end.

build_prefix_counts(S) ->
    build_prefix_counts_loop(S, gb_sets:new(), []).

build_prefix_counts_loop([], _Set, Acc) ->
    lists:reverse(Acc); % Reverse to get [P0, P1, ..., P_{N-1}]
build_prefix_counts_loop([H|T], Set, Acc) ->
    NewSet = gb_sets:add(H, Set),
    NewCount = gb_sets:size(NewSet),
    build_prefix_counts_loop(T, NewSet, [NewCount | Acc]).

build_suffix_counts(S) ->
    % Process the string in reverse to build suffix counts from right to left.
    % The accumulator will naturally be in the correct order [S0, S1, ..., S_{N-1}]
    % after processing the reversed input list.
    build_suffix_counts_loop(lists:reverse(S), gb_sets:new(), []).

build_suffix_counts_loop([], _Set, Acc) ->
    Acc; % Already in correct order: [S0, S1, ..., S_{N-1}]
build_suffix_counts_loop([H|T], Set, Acc) ->
    NewSet = gb_sets:add(H, Set),
    NewCount = gb_sets:size(NewSet),
    build_suffix_counts_loop(T, NewSet, [NewCount | Acc]).