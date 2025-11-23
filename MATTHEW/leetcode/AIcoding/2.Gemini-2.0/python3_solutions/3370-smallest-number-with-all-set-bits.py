class Solution:
    def smallestNumber(self, n: int) -> int:
        return (1 << n) - 1