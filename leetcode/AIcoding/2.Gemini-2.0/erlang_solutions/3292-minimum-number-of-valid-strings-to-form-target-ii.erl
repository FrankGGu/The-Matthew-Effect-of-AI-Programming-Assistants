-module(minimum_number_of_valid_strings_to_form_target_ii).
-export([min_number_of_valid_strings/2]).

min_number_of_valid_strings(Words, Target) ->
    length(solve(Words, Target, [])).

solve(Words, Target, Acc) ->
    case Target of
        "" ->
            Acc;
        _ ->
            case find_first_match(Words, Target) of
                none ->
                    [Target | Acc];
                {Word, Index} ->
                    RemainingTarget = string:sub_string(Target, Index + string:len(Word) + 1, string:len(Target)),
                    solve(Words, RemainingTarget, Acc)
            end
    end.

find_first_match(Words, Target) ->
    find_first_match_helper(Words, Target, 1).

find_first_match_helper([], _Target, _Index) ->
    none;
find_first_match_helper([Word | Rest], Target, Index) ->
    case string:str(Target, Word) of
        0 ->
            find_first_match_helper(Rest, Target, Index + 1);
        Pos ->
            {Word, Pos - 1}
    end.