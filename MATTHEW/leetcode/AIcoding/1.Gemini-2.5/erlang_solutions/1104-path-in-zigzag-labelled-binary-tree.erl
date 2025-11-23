-module(solution).
-export([pathInZigZagTree/1]).

pathInZigZagTree(Label) ->
    path_to_root(Label, []).

path_to_root(1, Acc) ->
    [1 | Acc];
path_to_root(Label, Acc) ->
    L = floor(math:log2(Label)) + 1,
    MinVal = 1 bsl (L-1),
    MaxVal = (1 bsl L) - 1,

    Pos = if
              L rem 2 == 1 ->
                  Label - MinVal;
              true ->
                  MaxVal - Label
          end,

    ParentPos = Pos div 2,

    L_parent = L - 1,
    MinValParent = 1 bsl (L_parent-1),
    MaxValParent = (1 bsl L_parent) - 1,

    ParentLabel = if
                      L_parent rem 2 == 1 ->
                          MinValParent + ParentPos;
                      true ->
                          MaxValParent - ParentPos
                  end,
    path_to_root(ParentLabel, [Label | Acc]).