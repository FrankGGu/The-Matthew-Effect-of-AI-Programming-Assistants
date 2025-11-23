-module(longest_substring_one_repeating_character).
-export([max_rep_opt1/2]).

max_rep_opt1(S, C) ->
    max_rep_opt1_helper(S, C, 0, 0, 0, 0, []).

max_rep_opt1_helper([], _C, MaxLen, CurrLen, PrevLen, PrevCharLen, Runs) ->
    lists:max([MaxLen, CurrLen + PrevCharLen + (case length(Runs) > 1 of true -> 1; false -> 0 end)]);

max_rep_opt1_helper([H|T], C, MaxLen, CurrLen, PrevLen, PrevCharLen, Runs) ->
    case H == C of
        true ->
            max_rep_opt1_helper(T, C, MaxLen, CurrLen + 1, PrevLen, PrevCharLen, Runs);
        false ->
            case PrevCharLen == 0 of
                true ->
                    max_rep_opt1_helper(T, H, MaxLen, 1, CurrLen, 0, Runs);
                false ->
                    NewRuns = [CurrLen|Runs];
                    NewMaxLen = lists:max([MaxLen, CurrLen + PrevCharLen + (case length(NewRuns) > 1 of true -> 1; false -> 0 end)]);
                    max_rep_opt1_helper(T, H, NewMaxLen, 1, CurrLen, PrevCharLen, NewRuns)
            end
    end.