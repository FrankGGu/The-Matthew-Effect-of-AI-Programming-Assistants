class Solution:
    def cuttingBamboo(self, n: int) -> int:
        if n == 2:
            return 1
        if n == 3:
            return 2

        remainder = n % 3
        if remainder == 0:
            return pow(3, n // 3)
        elif remainder == 1:
            # If n % 3 == 1, e.g., n=4 (3+1), it's better to break one 3 and the 1 into 2+2.
            # So, 3^(k-1) * 2 * 2 = 3^(k-1) * 4
            return pow(3, n // 3 - 1) * 4
        else: # remainder == 2
            # If n % 3 == 2, e.g., n=5 (3+2), it's optimal to use 3 and 2.
            # So, 3^k * 2
            return pow(3, n // 3) * 2