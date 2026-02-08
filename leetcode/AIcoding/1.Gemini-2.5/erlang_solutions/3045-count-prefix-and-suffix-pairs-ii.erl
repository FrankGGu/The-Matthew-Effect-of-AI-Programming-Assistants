-module(solution).
-export([countPrefixSuffixPairs/1]).

p() -> 31.
m() -> 1000000007.

compute_all_prefix_hashes_array(String) ->
    P = p(),
    M = m(),
    {_, HashesReversed} = lists:foldl(fun(Char, {AccHash, Hashes}) ->
                                              NewHash = (AccHash * P + (Char - $a' + 1)) rem M,
                                              {NewHash, [NewHash | Hashes]}
                                      end, {0, []}, String),
    array:from_list(lists:reverse(HashesReversed)).

countPrefixSuffixPairs(Words) ->
    N = length(Words),

    WordPropsList = lists:map(fun(Word) ->
                                  Len = length(Word),
                                  AllPrefixHashesArray = compute_all_prefix_hashes_array(Word),
                                  FullHash = array:get(Len - 1, AllPrefixHashesArray),

                                  ReverseWord = lists:reverse(Word),
                                  AllReversePrefixHashesArray = compute_all_prefix_hashes_array(ReverseWord),
                                  ReverseFullHash = array:get(Len - 1, AllReversePrefixHashesArray),

                                  {Len, FullHash, ReverseFullHash, AllPrefixHashesArray, AllReversePrefixHashesArray}
                          end, Words),

    WordPropsArray = array:from_list(WordPropsList),

    Count = lists:foldl(fun(I, Acc) ->
                                {LenI, HashI, ReverseHashI, _, _} = array:get(I, WordPropsArray),

                                InnerCount = lists:foldl(fun(J, InnerAcc) ->
                                                                 {LenJ, _, _, AllPrefixHashesJ, AllReversePrefixHashesJ} = array:get(J, WordPropsArray),

                                                                 if
                                                                     LenI > LenJ ->
                                                                         InnerAcc;
                                                                     true ->
                                                                         PrefixHashJ = array:get(LenI - 1, AllPrefixHashesJ),
                                                                         IsPrefix = (HashI == PrefixHashJ),

                                                                         ReversePrefixHashJ = array:get(LenI - 1, AllReversePrefixHashesJ),
                                                                         IsSuffix = (ReverseHashI == ReversePrefixHashJ),

                                                                         if
                                                                             IsPrefix and IsSuffix ->
                                                                                 InnerAcc + 1;
                                                                             true ->
                                                                                 InnerAcc
                                                                         end
                                                                 end
                                                         end, 0, lists:seq(I + 1, N - 1)),
                                Acc + InnerCount
                        end, 0, lists:seq(0, N - 2)),
    Count.