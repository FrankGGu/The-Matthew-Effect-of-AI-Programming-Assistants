-module(solution).

-export([split_list/2]).

-type node() :: {Value, Node} | nil.
-type list() :: [node()].

-record(part, {nodes = []}).

split_list(List, k) ->
    Length = length(List),
    PartSize = div(Length, k),
    Remainder = rem(Length, k),
    split(List, PartSize, Remainder, k).

split([], _, _, 0) -> [];
split(List, PartSize, Remainder, K) ->
    {Part, Rest} = split_part(List, PartSize + (if Remainder > 0 -> 1; true -> 0 end)),
    [Part | split(Rest, PartSize, Remainder - 1, K - 1)].

split_part(List, Size) when Size == 0 -> 
    {[], List};
split_part([{Value, Next} | Rest], Size) ->
    case Size of
        1 -> 
            {[{Value, Next}], Rest};
        _ -> 
            {Part, Remaining} = split_part(Rest, Size - 1),
            {[{Value, Next} | Part], Remaining}
    end.