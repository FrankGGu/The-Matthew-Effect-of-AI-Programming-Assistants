-module(solution).
-export([rearrange_k_substrings_to_form_target_string/2]).

build_freq_map(Str) ->
    lists:foldl(
        fun(Char, Map) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map)
        end,
        #{},
        Str
    ).

rearrange_k_substrings_to_form_target_string(S, Target) ->
    S_Freq = build_freq_map(S),
    Target_Freq = build_freq_map(Target),

    maps:fold(
        fun(Char, TargetCount, Acc) ->
            case maps:get(Char, S_Freq, 0) of
                0 ->
                    0;
                S_Count ->
                    min(Acc, S_Count div TargetCount)
            end
        end,
        infinity,
        Target_Freq
    ).