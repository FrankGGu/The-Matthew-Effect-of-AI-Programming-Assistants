class Solution:
    def minCount(self, coins: list[int]) -> int:
        total_operations = 0
        for c in coins:
            total_operations += (c + 1) // 2
        return total_operations