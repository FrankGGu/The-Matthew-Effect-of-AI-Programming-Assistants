-module(solution).
-export([bitwise_ors_of_subarrays/1]).

bitwise_ors_of_subarrays(A) ->
    {FinalTotalOrs, _} = lists:foldl(
        fun(Num, {AccTotalOrs, AccPrevOrs}) ->
            NewOrs = sets:new(),
            sets:add_element(Num, NewOrs),

            sets:fold(
                fun(PrevOr, TempNewOrs) ->
                    sets:add_element(PrevOr bor Num, TempNewOrs)
                end,
                NewOrs,
                AccPrevOrs
            ),

            UpdatedTotalOrs = sets:fold(
                fun(CurrentOr, TempTotalOrs) ->
                    sets:add_element(CurrentOr, TempTotalOrs)
                end,
                AccTotalOrs,
                NewOrs
            ),
            {UpdatedTotalOrs, NewOrs}
        end,
        {sets:new(), sets:new()},
        A
    ),
    sets:size(FinalTotalOrs).