-module(can_convert_string).
-export([canConvertString/3]).

canConvertString(S, T, K) ->
    case length(S) /= length(T) of
        true ->
            false;
        false ->
            canConvertStringHelper(S, T, K, [])
    end.

canConvertStringHelper([], [], _, _) ->
    true;
canConvertStringHelper([SH | ST], [TH | TT], K, Used) ->
    Diff = (TH - SH) rem 26,
    DiffAbs = if Diff < 0 then Diff + 26 else Diff end,
    case lists:member(DiffAbs, Used) of
        true ->
            case DiffAbs + 26 > K of
                true ->
                    false;
                false ->
                    canConvertStringHelper(ST, TT, K, Used ++ [DiffAbs + 26])
            end;
        false ->
            case DiffAbs > K of
                true ->
                    false;
                false ->
                    canConvertStringHelper(ST, TT, K, Used ++ [DiffAbs])
            end
    end.