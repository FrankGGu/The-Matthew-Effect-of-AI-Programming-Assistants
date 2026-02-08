-module(max_set_size).
-export([maximum_set_size/1]).

maximum_set_size(Nums) ->
    Len = length(Nums),
    Half = (Len + 1) div 2,
    Set = sets:from_list(Nums),
    SetSize = sets:size(Set),
    if SetSize > Half then
        Len - (SetSize - Half)
    else
        SetSize
    end.