-module(solution).
-export([find_original_typed_string_ii/2]).

find_original_typed_string_ii(S, T) ->
    LenS = length(S),
    LenT = length(T),
    STuple = list_to_tuple(S),
    TTuple = list_to_tuple(T),
    {LCS_Length, _} = lcs_dp_memo(STuple, TTuple, 0, 0, LenS, LenT, #{}),
    LenS - LCS_Length.

lcs_dp_memo(_STuple, _TTuple, I, _J, MaxS, _MaxT, Memo) when I == MaxS ->
    {0, Memo};
lcs_dp_memo(_STuple, _TTuple, _I, J, _MaxS, MaxT, Memo) when J == MaxT ->
    {0, Memo};
lcs_dp_memo(STuple, TTuple, I, J, MaxS, MaxT, Memo) ->
    case maps:get({I, J}, Memo, not_found) of
        not_found ->
            CharS = element(I + 1, STuple),
            CharT = element(J + 1, TTuple),

            Result = 
                if
                    CharS == CharT ->
                        {Res1, Memo1} = lcs_dp_memo(STuple, TTuple, I + 1, J + 1, MaxS, MaxT, Memo),
                        1 + Res1;
                    true ->
                        {Res2, Memo2} = lcs_dp_memo(STuple, TTuple, I + 1, J, MaxS, MaxT, Memo),
                        {Res3, Memo3} = lcs_dp_memo(STuple, TTuple, I, J + 1, MaxS, MaxT, Memo2),
                        max(Res2, Res3)
                end,

            {Result, maps:put({I, J}, Result, Memo)};
        Value ->
            {Value, Memo}
    end.