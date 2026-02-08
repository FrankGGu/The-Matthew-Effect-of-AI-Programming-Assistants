-module(linked_list).
-export([constructor/0, get/2, add_at_head/2, add_at_tail/2, add_at_index/3, delete_at_index/2]).

constructor() ->
    {null, 0}.

get({List, Size}, Index) when Index >= 0, Index < Size ->
    get(List, Index, 0);
get(_, _) ->
    -1.

get(null, _, _) ->
    -1;
get({Value, Next}, Index, Current) when Index == Current ->
    Value;
get({_, Next}, Index, Current) ->
    get(Next, Index, Current + 1).

add_at_head({List, Size}, Value) ->
    {{Value, List}, Size + 1}.

add_at_tail({List, Size}, Value) ->
    {add_at_tail(List, Value), Size + 1}.

add_at_tail(null, Value) ->
    {Value, null};
add_at_tail({Value, Next}, ValueToAdd) ->
    {Value, add_at_tail(Next, ValueToAdd)}.

add_at_index({List, Size}, Index, Value) when Index =< 0 ->
    add_at_head({List, Size}, Value);
add_at_index({List, Size}, Index, Value) when Index >= Size ->
    add_at_tail({List, Size}, Value);
add_at_index({List, Size}, Index, Value) ->
    {add_at_index(List, Index, Value, 0), Size + 1}.

add_at_index(null, _, _, _) ->
    {null, null};
add_at_index({Value, Next}, Index, ValueToAdd, Current) when Index == Current ->
    {ValueToAdd, {Value, Next}};
add_at_index({Value, Next}, Index, ValueToAdd, Current) ->
    {Value, add_at_index(Next, Index, ValueToAdd, Current + 1)}.

delete_at_index({List, Size}, Index) when Index >= 0, Index < Size ->
    {delete_at_index(List, Index, 0), Size - 1};
delete_at_index(List, _) ->
    {List, Size}.

delete_at_index(null, _, _) ->
    null;
delete_at_index({_, Next}, Index, Current) when Index == Current ->
    Next;
delete_at_index({Value, Next}, Index, Current) ->
    {Value, delete_at_index(Next, Index, Current + 1)}.