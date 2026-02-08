-module(solution).
-export([min_insertions/1]).

min_insertions(S) ->
    min_insertions_impl(S, 0, 0, 0, length(S)).

min_insertions_impl(_S, Idx, OpenCount, Insertions, N) when Idx >= N ->
    Insertions + OpenCount * 2;
min_insertions_impl(S, Idx, OpenCount, Insertions, N) ->
    Char = string:at(S, Idx + 1), % string:at is 1-indexed
    case Char of
        $( ->
            min_insertions_impl(S, Idx + 1, OpenCount + 1, Insertions, N);
        $) ->
            NewInsertions = case OpenCount > 0 of
                                true -> Insertions;
                                false -> Insertions + 1 % No open '(', need to insert one
                            end,
            NewOpenCount = case OpenCount > 0 of
                               true -> OpenCount - 1;
                               false -> OpenCount % The inserted '(' doesn't become part of 'OpenCount' for future matches
                           end,

            % Check if next char is also ')'
            case Idx + 1 < N andalso string:at(S, Idx + 2) == $) of
                true -> % Found "))"
                    min_insertions_impl(S, Idx + 2, NewOpenCount, NewInsertions, N);
                false -> % Found single ')'
                    % Need to insert one ')' to make it "))"
                    min_insertions_impl(S, Idx + 1, NewOpenCount, NewInsertions + 1, N)
            end
    end.