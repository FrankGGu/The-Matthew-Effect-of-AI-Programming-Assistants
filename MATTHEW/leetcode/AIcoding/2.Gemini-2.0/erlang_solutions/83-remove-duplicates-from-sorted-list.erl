-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates(List) ->
  delete_duplicates_helper(List, []).

delete_duplicates_helper([], Acc) ->
  lists:reverse(Acc);
delete_duplicates_helper([H | T], Acc) ->
  case lists:member(H, Acc) of
    true ->
      delete_duplicates_helper(T, Acc);
    false ->
      delete_duplicates_helper(T, [H | Acc])
  end.

```
```erlang
-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates([]) -> [];
delete_duplicates([H]) -> [H];
delete_duplicates([H1, H2 | T]) ->
  if
    H1 == H2 ->
      delete_duplicates([H2 | T]);
    true ->
      [H1 | delete_duplicates([H2 | T])]
  end.
```
```erlang
-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates([]) -> [];
delete_duplicates([H|T]) ->
    delete_duplicates(H, T, [H]).

delete_duplicates(Current, [], Acc) ->
    lists:reverse(Acc);
delete_duplicates(Current, [H|T], Acc) ->
    if H =:= Current then
        delete_duplicates(Current, T, Acc)
    else
        delete_duplicates(H, T, [H|Acc])
    end.
```
```erlang
-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates([]) -> [];
delete_duplicates([H|T]) ->
    delete_duplicates(H, T, [H]).

delete_duplicates(Current, [], Acc) ->
    lists:reverse(Acc);
delete_duplicates(Current, [H|T], Acc) ->
    if H == Current then
        delete_duplicates(Current, T, Acc)
    else
        delete_duplicates(H, T, [H|Acc])
    end.
```
```erlang
-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates([]) -> [];
delete_duplicates([H|T]) ->
  delete_duplicates_helper(H, T, [H]).

delete_duplicates_helper(Current, [], Acc) ->
  lists:reverse(Acc);
delete_duplicates_helper(Current, [H|T], Acc) ->
  if H == Current then
    delete_duplicates_helper(Current, T, Acc)
  else
    delete_duplicates_helper(H, T, [H|Acc])
  end.

```
```erlang
-module(remove_duplicates).
-export([delete_duplicates/1]).

delete_duplicates([]) -> [];
delete_duplicates([H | T]) ->
    delete_duplicates_helper(T, [H], H).

delete_duplicates_helper([], Acc, _) ->
    lists:reverse(Acc);
delete_duplicates_helper([H | T], Acc, Last) ->
    if H == Last then
        delete_duplicates_helper(T, Acc, Last)
    else
        delete_duplicates_helper(T, [H | Acc], H)
    end.