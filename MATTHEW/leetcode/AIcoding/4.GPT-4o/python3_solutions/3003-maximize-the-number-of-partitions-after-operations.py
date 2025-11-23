class Solution:
    def maximizePartitions(self, n: int, k: int) -> int:
        if n <= k:
            return n
        return (n + k - 1) // k