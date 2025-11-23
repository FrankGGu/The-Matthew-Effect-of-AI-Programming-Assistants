class Solution:
    def solve(self, n: int) -> int:
        if n == 0:
            return 0

        N_minus_1 = n - 1
        remainder = N_minus_1 % 4

        if remainder == 0:
            return N_minus_1
        elif remainder == 1:
            return 1
        elif remainder == 2:
            return N_minus_1 + 1
        else:
            return 0