-module(maximize_subarrays).
-export([max_subarrays/1]).

max_subarrays(Nums) ->
  max_subarrays(Nums, 0, 0, []).

max_subarrays([], Count, _, Acc) ->
  Count;
max_subarrays([H|T], Count, Last, Acc) ->
  case H > Last of
    true ->
      max_subarrays(T, Count + 1, H, [H|Acc]);
    false ->
      case find_conflict(T, H, Acc) of
        true ->
          max_subarrays(remove_conflict(T, H, Acc), Count, Last, Acc);
        false ->
          max_subarrays(T, Count + 1, H, [H|Acc])
      end
  end.

find_conflict([], _, _) ->
  false;
find_conflict(Nums, H, Acc) ->
  find_conflict(Nums, H, Acc, lists:reverse(Acc)).

find_conflict(_, _, _, []) ->
  false;
find_conflict(_Nums, H, _, [A|_]) when H =< A ->
  true;
find_conflict(_Nums, _H, _, [_|[]]) ->
  false;
find_conflict(Nums, H, Acc, [_|Rest]) ->
  find_conflict(Nums, H, Acc, Rest).

remove_conflict(Nums, H, Acc) ->
  remove_conflict(Nums, H, Acc, lists:reverse(Acc)).

remove_conflict(Nums, H, Acc, []) ->
    Nums;
remove_conflict(Nums, H, Acc, [A|Rest]) when H =< A ->
  RestAcc = lists:reverse(Rest);
  lists:append(RestAcc, Nums);
remove_conflict(Nums, H, Acc, [_|Rest]) ->
  remove_conflict(Nums, H, Acc, Rest).