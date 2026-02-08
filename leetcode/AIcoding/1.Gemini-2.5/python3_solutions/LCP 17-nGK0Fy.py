import math

class Solution:
    def robot(self, n: int) -> int:
        if n == 1:
            return 0

        # The sum x + y doubles with each operation.
        # Initially, x = 1, y = 0, so x + y = 1.
        # After k operations, x + y = 2^k.
        # We want to reach x = n. Since y >= 0, we must have x <= x + y.
        # Therefore, n <= 2^k.
        # This implies k >= log2(n).
        # Since k must be an integer, the minimum number of operations k is ceil(log2(n)).
        # It can be proven that this minimum number of operations is always achievable.
        return math.ceil(math.log2(n))