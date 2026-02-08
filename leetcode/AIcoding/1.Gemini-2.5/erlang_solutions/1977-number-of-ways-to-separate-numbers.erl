-module(solution).
-export([number_of_ways/2]).

-define(MOD, 1000000007).

number_of_ways(S, K) ->
    N = string:len(S),
    K_str = integer_to_list(K), % K_str will be a list of characters
    K_len = string:len(K_str),
    Memo = maps:new(),
    {Result, _} = solve(0, S, K_str, K_len, N, Memo),
    Result.

solve(Index, _, _, _, N, Memo) when Index == N ->
    {1, Memo};
solve(Index, S, K_str, K_len, N, Memo) ->
    case maps:find(Index, Memo) of
        {ok, Val} -> {Val, Memo};
        error ->
            {Result, UpdatedMemo} = calculate_ways(Index, S, K_str, K_len, N, Memo),
            {Result, maps:put(Index, Result, UpdatedMemo)}
    end.

calculate_ways(CurrentIndex, S, K_str, K_len, N, Memo) ->
    CharAtIndex = string:at(S, CurrentIndex + 1),
    if CharAtIndex == $0 ->
        solve(CurrentIndex + 1, S, K_str, K_len, N, Memo);
    true ->
        loop_j(CurrentIndex, CurrentIndex, 0, S, K_str, K_len, N, Memo)
    end.

loop_j(StartIndex, CurrentJ, Acc, S, K_str, K_len, N, Memo) when CurrentJ >= N ->
    {Acc, Memo};
loop_j(StartIndex, CurrentJ, Acc, S, K_str, K_len, N, Memo) ->
    SubStrLen = CurrentJ - StartIndex + 1,
    SubStr = string:substr(S, StartIndex + 1, SubStrLen),

    case is_valid_num(SubStr, SubStrLen, K_str, K_len) of
        true ->
            {NextResult, UpdatedMemo} = solve(CurrentJ + 1, S, K_str, K_len, N, Memo),
            NewAcc = (Acc + NextResult) rem ?MOD,
            loop_j(StartIndex, CurrentJ + 1, NewAcc, S, K_str, K_len, N, UpdatedMemo);
        false ->
            {Acc, Memo}
    end.

is_valid_num(SubStr, SubStrLen, K_str, K_len) ->
    if SubStrLen < K_len ->
        true;
    SubStrLen > K_len ->
        false;
    SubStrLen == K_len ->
        string:compare(SubStr, K_str) =/= gt
    end.