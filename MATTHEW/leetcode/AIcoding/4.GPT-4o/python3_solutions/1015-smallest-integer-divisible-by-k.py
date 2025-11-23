class Solution:
    def smallestRepunitDivByK(self, K: int) -> int:
        if K % 2 == 0 or K % 5 == 0:
            return -1
        remainder = 1
        length = 1
        while remainder % K != 0:
            remainder = (remainder * 10 + 1) % K
            length += 1
        return length