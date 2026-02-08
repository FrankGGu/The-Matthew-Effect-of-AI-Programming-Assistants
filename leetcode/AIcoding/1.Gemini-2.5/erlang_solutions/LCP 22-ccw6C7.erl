-module(solution).
-export([solve/2]).

is_valid_row_mask(Mask, M) ->
    is_valid_row_mask_recursive(Mask, M - 1).

is_valid_row_mask_recursive(_Mask, 0) -> true;
is_valid_row_mask_recursive(Mask, Col) ->
    Bit1 = (Mask bsr Col) band 1,
    Bit0 = (Mask bsr (Col - 1)) band 1,
    if
        Bit1 == 1 andalso Bit0 == 1 -> false;
        true -> is_valid_row_mask_recursive(Mask, Col - 1)
    end.

are_compatible_masks(Mask1, Mask2, M) ->
    are_compatible_masks_recursive(Mask1, Mask2, M - 1).

are_compatible_masks_recursive(_Mask1, _Mask2, -1) -> true;
are_compatible_masks_recursive(Mask1, Mask2, Col) ->
    Bit1 = (Mask1 bsr Col) band 1,
    Bit2 = (Mask2 bsr Col) band 1,
    if
        Bit1 == 1 andalso Bit2 == 1 -> false;
        true -> are_compatible_masks_recursive(Mask1, Mask2, Col - 1)
    end.

solve(N, M) ->
    if
        N == 0; M == 0 -> 1; %% Convention: one way to paint an empty grid
        true ->
            MaxMask = (1 bsl M) - 1,

            %% Step 1: Generate all valid row masks
            ValidRowMasks = [Mask || Mask <- lists:seq(0, MaxMask), is_valid_row_mask(Mask, M)],

            %% Step 2: Initialize DP table for the first row
            %% DP state: Map = #{Mask => Count} for the current row
            DP = lists:foldl(fun(Mask, Acc) ->
                                     Acc#{Mask => 1}
                             end, #{}, ValidRowMasks),

            %% Step 3: Iterate through rows from 1 to N-1
            FinalDP = lists:foldl(fun(_RowIdx, CurrentDP) ->
                                          NewDP = #{},
                                          lists:foldl(fun(CurrentMask, AccNewDP) ->
                                                              CountForCurrentMask = 
                                                                  lists:foldl(fun(PrevMask, Sum) ->
                                                                                      case maps:find(PrevMask, CurrentDP) of
                                                                                          {ok, PrevCount} ->
                                                                                              if
                                                                                                  are_compatible_masks(PrevMask, CurrentMask, M) -> Sum + PrevCount;
                                                                                                  true -> Sum
                                                                                              end;
                                                                                          error -> Sum %% Should not happen if PrevMask is in ValidRowMasks
                                                                                      end
                                                                              end, 0, ValidRowMasks),

                                                              if
                                                                  CountForCurrentMask > 0 -> AccNewDP#{CurrentMask => CountForCurrentMask};
                                                                  true -> AccNewDP
                                                              end
                                                      end, NewDP, ValidRowMasks)
                                  end, DP, lists:seq(1, N - 1)),

            %% Step 4: Sum up counts for the last row
            lists:foldl(fun(Mask, Sum) ->
                                case maps:find(Mask, FinalDP) of
                                    {ok, Count} -> Sum + Count;
                                    error -> Sum
                                end
                        end, 0, ValidRowMasks)
    end.