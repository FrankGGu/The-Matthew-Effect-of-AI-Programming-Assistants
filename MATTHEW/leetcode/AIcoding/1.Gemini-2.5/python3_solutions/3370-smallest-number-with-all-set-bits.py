class Solution:
    def smallestNumberWithAllSetBits(self, n: int) -> int:
        return (1 << n) - 1