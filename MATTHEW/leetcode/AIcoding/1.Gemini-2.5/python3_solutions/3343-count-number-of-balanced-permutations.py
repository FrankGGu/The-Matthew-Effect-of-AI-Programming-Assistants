import math

class Solution:
    def countBalancedPermutations(self, n: int) -> int:
        if n == 0:
            return 1

        comb_2n_n = math.comb(2 * n, n)
        catalan_n = comb_2n_n // (n + 1)

        return catalan_n