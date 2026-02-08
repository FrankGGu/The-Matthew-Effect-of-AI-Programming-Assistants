class Solution:
    def passThePillow(self, n: int, time: int) -> int:
        cycle_len = (n - 1) * 2
        remainder = time % cycle_len
        if remainder < n:
            return remainder + 1
        else:
            return n - (remainder - (n - 1))