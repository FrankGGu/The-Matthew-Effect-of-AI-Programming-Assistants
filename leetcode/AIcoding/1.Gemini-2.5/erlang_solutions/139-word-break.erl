-module(solution).
-export([wordBreak/2]).

wordBreak(S, WordDict) ->
    DictSet = gb_sets:from_list(WordDict),
    LenS = byte_size(S),
    Dp = array:new([{size, LenS + 1}, {fixed, true}, {default, false}]),
    Dp0 = array:set(0, true, Dp),
    word_break_dp(1, LenS, S, DictSet, Dp0).

word_break_dp(I, LenS, S, DictSet, Dp) when I =< LenS ->
    UpdatedDp = try_set_dp_i(0, I, S, DictSet, Dp),
    word_break_dp(I + 1, LenS, S, DictSet, UpdatedDp);
word_break_dp(_I, LenS, _S, _DictSet, Dp) ->
    array:get(LenS, Dp).

try_set_dp_i(J, I, S, DictSet, Dp) when J < I ->
    case array:get(I, Dp) of
        true ->
            Dp;
        false ->
            case array:get(J, Dp) of
                true ->
                    SubString = binary:part(S, J, I - J),
                    case gb_sets:is_member(SubString, DictSet) of
                        true ->
                            array:set(I, true, Dp);
                        false ->
                            try_set_dp_i(J + 1, I, S, DictSet, Dp)
                    end;
                false ->
                    try_set_dp_i(J + 1, I, S, DictSet, Dp)
            end
    end;
try_set_dp_i(_J, _I, _S, _DictSet, Dp) ->
    Dp.