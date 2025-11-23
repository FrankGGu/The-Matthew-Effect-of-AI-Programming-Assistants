-module(solution).
-export([min_extra_char/2]).

min_extra_char(S, Dictionary) ->
    DictSet = sets:from_list(Dictionary),
    N = string:len(S),

    DPMap = lists:foldl(
        fun(I, AccDPMap) ->
            Val1 = maps:get(I-1, AccDPMap) + 1,

            CurrentMinForI = lists:foldl(
                fun(J, MinSoFar) ->
                    Substr = string:substr(S, J + 1, I - J),
                    case sets:is_element(Substr, DictSet) of
                        true ->
                            min(MinSoFar, maps:get(J, AccDPMap));
                        false ->
                            MinSoFar
                    end
                end,
                Val1,
                lists:seq(0, I-1)
            ),

            maps:put(I, CurrentMinForI, AccDPMap)
        end,
        #{0 => 0},
        lists:seq(1, N)
    ),

    maps:get(N, DPMap).