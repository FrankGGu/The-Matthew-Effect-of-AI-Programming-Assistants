-module(solution).
-export([substring_xor_queries/2]).

get_bit_length(0) -> 1;
get_bit_length(N) when N > 0 ->
    erlang:trunc(math:log2(N)) + 1.

substring_xor_queries(S, Queries) ->
    S_bin = list_to_binary(S),
    N = byte_size(S_bin),

    PrecomputedMap = precompute_substring_values(S_bin, N),

    process_queries(Queries, PrecomputedMap).

precompute_substring_values(S_bin, N) ->
    MaxLen = 31, % Max length of substring to consider (since third <= 10^9 < 2^30, so max 30 bits for 10^9, 31 for 2^30)

    AccMap = maps:new(),

    % Iterate through all possible start indices I
    AccMap2 = lists:foldl(fun(I, CurrentMap) ->
        % Iterate through all possible lengths L from 1 to MaxLen
        lists:foldl(fun(L, InnerMap) ->
            EndIndex = I + L - 1,
            if 
                EndIndex < N -> % Ensure substring is within bounds
                    SubBin = binary:part(S_bin, I, L),
                    Value = binary:decode_unsigned(SubBin),
                    maps:update_with(Value, fun(List) -> [I | List] end, [I], InnerMap);
                true ->
                    InnerMap % Substring goes out of bounds, stop extending for this I
            end
        end, CurrentMap, lists:seq(1, MaxLen))
    end, AccMap, lists:seq(0, N - 1)),

    % Convert lists of start indices to arrays for O(log N) lookup
    % Reverse each list of start indices to make them sorted ascendingly before converting to array
    maps:map(fun(_K, V) -> array:from_list(lists:reverse(V)) end, AccMap2).

process_queries(Queries, PrecomputedMap) ->
    lists:map(fun([First, Second, Third]) ->
        Len = get_bit_length(Third),

        MaxStartIdx = Second - Len + 1,

        if 
            MaxStartIdx < First -> % Impossible to fit a substring of length Len in [First, Second]
                false;
            true ->
                case maps:find(Third, PrecomputedMap) of
                    {ok, StartIndicesArray} ->
                        % Use binary search to find the first S_idx >= First in the sorted array
                        case find_first_ge_array(StartIndicesArray, First) of
                            undefined ->
                                false; % No start index found that is >= First
                            FirstCandidate ->
                                % Check if the found candidate also satisfies S_idx <= MaxStartIdx
                                FirstCandidate =< MaxStartIdx
                        end;
                    error ->
                        false % Third value not found in precomputed map
                end
        end
    end, Queries).

find_first_ge_array(Array, Target) ->
    array_size = array:size(Array),
    find_first_ge_array_rec(Array, Target, 0, array_size - 1, undefined).

find_first_ge_array_rec(_Array, _Target, Low, High, Candidate) when Low > High ->
    Candidate;
find_first_ge_array_rec(Array, Target, Low, High, Candidate) ->
    Mid = Low + (High - Low) div 2,
    Element = array:get(Mid, Array),

    if
        Element >= Target ->
            % Element is a potential candidate. Try to find an even smaller one on the left.
            find_first_ge_array_rec(Array, Target, Low, Mid - 1, Element);
        true -> % Element < Target
            % Element is too small. Search on the right.
            find_first_ge_array_rec(Array, Target, Mid + 1, High, Candidate)
    end.