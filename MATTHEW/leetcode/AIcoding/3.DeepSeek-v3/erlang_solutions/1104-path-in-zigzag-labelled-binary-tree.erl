-spec path_in_zig_zag_tree(Label :: integer()) -> [integer()].
path_in_zig_zag_tree(Label) ->
    Path = [],
    find_path(Label, Path).

find_path(1, Path) ->
    [1 | Path];
find_path(Label, Path) ->
    Level = trunc(math:log2(Label)) + 1,
    Start = trunc(math:pow(2, Level - 1)),
    End = trunc(math:pow(2, Level)) - 1,
    Parent = (Start + End - Label) div 2,
    find_path(Parent, [Label | Path]).