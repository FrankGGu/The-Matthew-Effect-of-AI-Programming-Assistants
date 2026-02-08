-module(solution).
-export([longestCommonPrefix/1]).

longestCommonPrefix(Strings) ->
    case Strings of
        [] -> "";
        _ ->
            Prefix = common_prefix(hd(Strings), tl(Strings)),
            Prefix
    end.

common_prefix(_, []) -> "";
common_prefix(Prefix, [H | T]) ->
    NewPrefix = common_prefix_helper(Prefix, H, length(Prefix), length(H)),
    common_prefix(NewPrefix, T).

common_prefix_helper([], _, _, _) -> [];
common_prefix_helper(_, [], _, _) -> [];
common_prefix_helper([P | Ps], [H | _], Index, HLength) when Index > HLength -> [];
common_prefix_helper([P | Ps], [H | _], Index, HLength) ->
    if
        P == H -> [P | common_prefix_helper(Ps, [H | []], Index + 1, HLength)];
        true -> []
    end.