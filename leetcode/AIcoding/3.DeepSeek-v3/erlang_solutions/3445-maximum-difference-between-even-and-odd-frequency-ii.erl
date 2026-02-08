-spec max_frequency_diff(Nums :: [integer()]) -> integer().
max_frequency_diff(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                          end, #{}, Nums),
    {EvenFreq, OddFreq} = maps:fold(fun(_, V, {Even, Odd}) -> 
                                        case V rem 2 of
                                            0 -> {[V | Even], Odd};
                                            1 -> {Even, [V | Odd]}
                                        end
                                    end, {[], []}, FreqMap),
    MaxEven = case EvenFreq of
                [] -> 0;
                _ -> lists:max(EvenFreq)
              end,
    MinEven = case EvenFreq of
                [] -> 0;
                _ -> lists:min(EvenFreq)
              end,
    MaxOdd = case OddFreq of
               [] -> 0;
               _ -> lists:max(OddFreq)
             end,
    MinOdd = case OddFreq of
               [] -> 0;
               _ -> lists:min(OddFreq)
             end,
    max(abs(MaxEven - MinOdd), abs(MaxOdd - MinEven)).