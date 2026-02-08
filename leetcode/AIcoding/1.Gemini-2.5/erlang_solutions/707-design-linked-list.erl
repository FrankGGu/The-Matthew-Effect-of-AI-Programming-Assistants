-module(mylist).
-export([new/0, get/2, addAtHead/2, addAtTail/2, addAtIndex/3, deleteAtIndex/2]).

new() ->
    {0, []}.

get({Length, List}, Index) when Index >= 0, Index < Length ->
    get_val_at_index(List, Index);
get(_, _, _) ->
    -1.

get_val_at_index([H|_], 0) ->
    H;
get_val_at_index([_|T], Index) ->
    get_val_at_index(T, Index - 1).

addAtHead({Length, List}, Val) ->
    {Length + 1, [Val | List]}.

addAtTail({Length, List}, Val) ->
    {Length + 1, List ++ [Val]}.

addAtIndex({Length, List}, Index, Val) when Index < 0 ->
    addAtHead({Length, List}, Val);
addAtIndex({Length, List}, Index, Val) when Index == Length ->
    addAtTail({Length, List}, Val);
addAtIndex({Length, List}, Index, Val) when Index > Length ->
    {Length, List};
addAtIndex({Length, List}, Index, Val) ->
    {Prefix, Suffix} = lists:split(Index, List),
    {Length + 1, Prefix ++ [Val | Suffix]}.

deleteAtIndex({Length, List}, Index) when Index < 0; Index >= Length ->
    {Length, List};
deleteAtIndex({Length, List}, Index) ->
    {Prefix, [_|Suffix]} = lists:split(Index, List),
    {Length - 1, Prefix ++ Suffix}.