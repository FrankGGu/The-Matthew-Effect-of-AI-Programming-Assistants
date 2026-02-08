-module(solution).
-export([findSecretWord/2]).

count_matches(Word1, Word2) ->
    lists:foldl(
        fun({C1, C2}, Acc) when C1 == C2 -> Acc + 1;
           (_, Acc) -> Acc
        end,
        0,
        lists:zip(Word1, Word2)
    ).

findSecretWord(Wordlist, Master) ->
    findSecretWord_loop(Wordlist, Master).

findSecretWord_loop(Wordlist, Master) ->
    {_MinMaxPartitionSize, BestGuessWord} = choose_best_guess_word(Wordlist, Wordlist),

    Matches = Master:guess(BestGuessWord),

    if Matches == 6 ->
        ok;
    else
        FilteredWordlist = lists:filter(
            fun(Word) ->
                count_matches(Word, BestGuessWord) == Matches
            end,
            Wordlist
        ),
        findSecretWord_loop(FilteredWordlist, Master)
    end.

choose_best_guess_word(Wordlist, Candidates) ->
    InitialMinMaxPartitionSize = length(Wordlist) + 1,
    InitialBestWord = hd(Candidates),

    lists:foldl(
        fun(CandidateWord, {CurrentMinMax, CurrentBestWord}) ->
            PartitionSizes = calculate_partition_sizes(CandidateWord, Wordlist),
            MaxPartitionSizeForCandidate = lists:max(maps:values(PartitionSizes)),

            if MaxPartitionSizeForCandidate < CurrentMinMax ->
                {MaxPartitionSizeForCandidate, CandidateWord};
            else
                {CurrentMinMax, CurrentBestWord}
            end
        end,
        {InitialMinMaxPartitionSize, InitialBestWord},
        Candidates
    ).

calculate_partition_sizes(GuessWord, Wordlist) ->
    InitialMap = #{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0},
    lists:foldl(
        fun(Word, Acc) ->
            Matches = count_matches(GuessWord, Word),
            maps:update_with(Matches, fun(V) -> V + 1 end, 1, Acc)
        end,
        InitialMap,
        Wordlist
    ).