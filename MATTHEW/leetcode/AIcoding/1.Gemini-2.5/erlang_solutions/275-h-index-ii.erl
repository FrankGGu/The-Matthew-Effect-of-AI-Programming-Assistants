-module(solution).
-export([h_index/1]).

h_index(Citations) ->
    N = length(Citations),
    binary_search(Citations, N, 1, N, 0).

binary_search(_Citations, _N, Low, High, Ans) when Low > High ->
    Ans;
binary_search(Citations, N, Low, High, Ans) ->
    Mid = Low + (High - Low) div 2,
    % In Erlang, lists:nth is 1-indexed.
    % We are looking for h = Mid.
    % The papers with at least Mid citations are Citations[N - Mid + 1]...Citations[N].
    % The minimum citation count among these Mid papers is Citations[N - Mid + 1].
    % So, we check if Citations[N - Mid + 1] >= Mid.
    CitationValue = lists:nth(N - Mid + 1, Citations),
    if
        CitationValue >= Mid ->
            % Mid is a possible H-index. Try for a larger one in the upper half.
            binary_search(Citations, N, Mid + 1, High, Mid);
        true ->
            % Mid is too large, or CitationValue is too small. Look in the lower half.
            binary_search(Citations, N, Low, Mid - 1, Ans)
    end.