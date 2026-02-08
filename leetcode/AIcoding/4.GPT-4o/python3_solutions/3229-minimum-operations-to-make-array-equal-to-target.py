class Solution:
    def minOperations(self, n: int, target: int) -> int:
        return abs(n - target) // 2 + (n - target) % 2