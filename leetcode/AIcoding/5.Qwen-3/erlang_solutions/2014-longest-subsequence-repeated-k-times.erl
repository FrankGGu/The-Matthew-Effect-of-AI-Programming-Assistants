-module(longest_subsequence_repeated_k_times).
-export([longest_repeating/2]).

longest_repeating(Seq, K) ->
    MaxLen = length(Seq),
    lists:foldl(fun Len -> 
        case find_longest(Seq, K, Len) of
            false -> 
                Len - 1;
            Result -> 
                Result
        end
    end, MaxLen, lists:seq(1, MaxLen)).

find_longest(Seq, K, Len) ->
    Candidates = generate_candidates(Seq, Len),
    lists:foldl(fun Candidate ->
        case is_valid(Seq, Candidate, K) of
            true -> 
                Candidate;
            false -> 
                false
        end
    end, false, Candidates).

generate_candidates(Seq, Len) ->
    Generate = fun(Len, Acc) ->
        case Len of
            0 -> Acc;
            _ -> Generate(Len - 1, [lists:sublist(Seq, Len) | Acc])
        end
    end,
    Generate(Len, []).

is_valid(Seq, Candidate, K) ->
    IsSubsequence = fun(S, T) ->
        lists:all(fun(Char) -> lists:member(Char, T) end, S)
    end,
    Count = count_occurrences(Seq, Candidate),
    Count >= K.

count_occurrences(Seq, Candidate) ->
    count_occurrences(Seq, Candidate, 0, 0).

count_occurrences([], _, _, Count) -> Count;
count_occurrences(Seq, Candidate, Pos, Count) ->
    case is_subsequence(Seq, Candidate, Pos) of
        true -> 
            count_occurrences(Seq, Candidate, Pos + length(Candidate), Count + 1);
        false -> 
            count_occurrences(Seq, Candidate, Pos + 1, Count)
    end.

is_subsequence(Seq, Candidate, Start) ->
    is_subsequence(Seq, Candidate, Start, 0).

is_subsequence(_, [], _, _) -> true;
is_subsequence(Seq, Candidate, Start, Index) ->
    case Index < length(Candidate) of
        true ->
            Char = lists:nth(Index + 1, Candidate),
            case lists:drop(Start, Seq) of
                [] -> false;
                Rest ->
                    case lists:member(Char, Rest) of
                        true ->
                            NewPos = Start + lists:search(Char, Rest),
                            is_subsequence(Seq, Candidate, NewPos, Index + 1);
                        false -> false
                    end
            end;
        false -> true
    end.