-module(freedom_trail).
-export([find_rotate_steps/2]).

find_rotate_steps(Ring, Key) ->
    LenR = length(Ring),
    LenK = length(Key),
    Memo = dict:new(),
    find_rotate_steps_helper(Ring, Key, 0, 0, LenR, LenK, Memo).

find_rotate_steps_helper(Ring, Key, RingIndex, KeyIndex, LenR, LenK, Memo) ->
    case dict:find({RingIndex, KeyIndex}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            case KeyIndex >= LenK of
                true ->
                    0;
                false ->
                    Char = lists:nth(KeyIndex + 1, Key),
                    Indices = find_all_indices(Ring, Char),
                    Steps = lists:map(fun(Index) ->
                                               Diff = abs(Index - RingIndex),
                                               Step1 = min(Diff, LenR - Diff),
                                               Step1 + 1 + find_rotate_steps_helper(Ring, Key, Index, KeyIndex + 1, LenR, LenK, Memo)
                                       end, Indices),
                    MinValue = lists:min(Steps),
                    dict:store({RingIndex, KeyIndex}, MinValue, Memo),
                    MinValue
            end
    end.

find_all_indices(String, Char) ->
    find_all_indices_helper(String, Char, 1, []).

find_all_indices_helper([], _, _, Acc) ->
    lists:reverse(Acc);
find_all_indices_helper([H | T], Char, Index, Acc) ->
    case H =:= Char of
        true ->
            find_all_indices_helper(T, Char, Index + 1, [Index | Acc]);
        false ->
            find_all_indices_helper(T, Char, Index + 1, Acc)
    end.