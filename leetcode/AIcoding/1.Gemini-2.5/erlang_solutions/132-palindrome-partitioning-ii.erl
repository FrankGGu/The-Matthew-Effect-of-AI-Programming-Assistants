-module(solution).
-export([min_cut/1]).

min_cut(S) ->
    StrList = binary_to_list(S),
    N = length(StrList),

    if N =:= 0 -> 0;
       N =:= 1 -> 0;
       true ->
         CharMap = lists:foldl(fun({Char, Idx}, Acc) -> maps:put(Idx, Char, Acc) end, #{}, lists:zip(StrList, lists:seq(0, N-1))),

         PalindromeMap = build_palindrome_map(CharMap, N),

         DPMap0 = #{0 => -1},
         DPMap1 = lists:foldl(fun(I, Acc) ->
                                   maps:put(I, I - 1, Acc)
                               end, DPMap0, lists:seq(1, N)),

         FinalDPMap = lists:foldl(fun(I, CurrentDPMap) ->
                                       MinCutsForI = lists:foldl(fun(J, MinCutsAcc) ->
                                                                     case maps:get(J, maps:get(I-1, PalindromeMap, #{})) of
                                                                         true ->
                                                                             min(MinCutsAcc, maps:get(J, CurrentDPMap) + 1);
                                                                         _ ->
                                                                             MinCutsAcc
                                                                     end
                                                                 end, maps:get(I, CurrentDPMap), lists:seq(0, I-1)),
                                       maps:put(I, MinCutsForI, CurrentDPMap)
                                   end, DPMap1, lists:seq(1, N)),

         maps:get(N, FinalDPMap)
    end.

build_palindrome_map(CharMap, N) ->
    InitialMap = #{},

    lists:foldl(fun(I, AccMapI) ->
        RowMap = lists:foldl(fun(J, AccMapJ) ->
            IsPalindrome = 
                if I == J ->
                    true;
                J == I + 1 ->
                    maps:get(I, CharMap) == maps:get(J, CharMap);
                true ->
                    maps:get(I, CharMap) == maps:get(J, CharMap) andalso
                    maps:get(J-1, maps:get(I+1, AccMapI, #{}), false)
                end,
            maps:put(J, IsPalindrome, AccMapJ)
        end, #{}, lists:seq(I, N-1)),
        maps:put(I, RowMap, AccMapI)
    end, InitialMap, lists:reverse(lists:seq(0, N-1))).