-spec print_vertically(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
print_vertically(S) ->
    Words = string:split(S, " ", all),
    MaxLen = lists:max([length(W) || W <- Words]),
    PaddedWords = [string:pad(W, MaxLen, trailing, $\s) || W <- Words],
    Transposed = transpose(PaddedWords),
    [string:trim(T, trailing) || T <- Transposed].

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Lists) ->
    [lists:append([hd(L) || L <- Lists]) | transpose([tl(L) || L <- Lists])].