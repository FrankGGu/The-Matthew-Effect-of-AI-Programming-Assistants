-module(solution).
-export([longest_common_subpath/2]).

longest_common_subpath(N, Paths) ->
    MinLen = lists:min([length(Path) || Path <- Paths]),
    Low = 1,
    High = MinLen,
    binary_search(Low, High, Paths).

binary_search(Low, High, Paths) when Low > High ->
    High;
binary_search(Low, High, Paths) ->
    Mid = (Low + High) div 2,
    case has_common_subpath(Paths, Mid) of
        true -> binary_search(Mid + 1, High, Paths);
        false -> binary_search(Low, Mid - 1, Paths)
    end.

has_common_subpath(Paths, Len) ->
    FirstPath = hd(Paths),
    Subpaths = get_subpaths(FirstPath, Len),
    lists:all(fun(Path) -> has_common(Path, Len, Subpaths) end, tl(Paths)).

get_subpaths(Path, Len) ->
    Subpaths = sets:new(),
    get_subpaths(Path, Len, 0, Subpaths).

get_subpaths(Path, Len, Start, Subpaths) when Start + Len > length(Path) ->
    Subpaths;
get_subpaths(Path, Len, Start, Subpaths) ->
    Subpath = lists:sublist(Path, Start + 1, Len),
    Hash = erlang:phash2(Subpath),
    NewSubpaths = sets:add_element(Hash, Subpaths),
    get_subpaths(Path, Len, Start + 1, NewSubpaths).

has_common(Path, Len, Subpaths) ->
    has_common(Path, Len, 0, Subpaths).

has_common(Path, Len, Start, Subpaths) when Start + Len > length(Path) ->
    false;
has_common(Path, Len, Start, Subpaths) ->
    Subpath = lists:sublist(Path, Start + 1, Len),
    Hash = erlang:phash2(Subpath),
    case sets:is_element(Hash, Subpaths) of
        true -> true;
        false -> has_common(Path, Len, Start + 1, Subpaths)
    end.