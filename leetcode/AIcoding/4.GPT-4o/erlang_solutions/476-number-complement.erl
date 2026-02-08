-module(solution).
-export([find_complement/1]).

-spec find_complement(integer()) -> integer().
find_complement(Num) ->
    % Calculate the number of bits in the binary representation of Num
    BitCount = trunc(math:log2(Num)) + 1,
    % Create a mask with all bits set to 1, having the same length as Num
    Mask = bsl(1, BitCount) - 1,
    % The complement of Num is obtained by XORing Num with the mask
    Num bxor Mask.
