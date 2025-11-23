-module(path_in_zigzag_labelled_binary_tree).
-export([path_in_zigzag/2]).

path_in_zigzag(1, 1) -> [1];
path_in_zigzag(Label, Target) ->
    Path = path_in_zigzag(Label, Target, []),
    lists:reverse(Path).

path_in_zigzag(Label, Target, Acc) ->
    case Label of
        Target -> [Label | Acc];
        _ ->
            Level = level(Label),
            IsOddLevel = (Level rem 2) == 1,
            if
                IsOddLevel ->
                    Parent = Label div 2,
                    path_in_zigzag(Parent, Target, [Label | Acc]);
                true ->
                    OriginalParent = Label div 2,
                    Max = 2 * (1 bsl (Level - 1)) - 1,
                    Min = 1 bsl (Level - 1),
                    ZigzagParent = Max - OriginalParent + Min,
                    path_in_zigzag(ZigzagParent, Target, [Label | Acc])
            end
    end.

level(Label) ->
    level(Label, 1).

level(Label, Level) ->
    case Label >= (1 bsl (Level - 1)) andalso Label < (1 bsl Level) of
        true -> Level;
        false -> level(Label, Level + 1)
    end.