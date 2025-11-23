class Solution:
    def maxJump(self, stones: List[int]) -> int:
        n = len(stones)
        max_dist = 0
        for i in range(1, n):
            dist = stones[i] - stones[i - 1]
            max_dist = max(max_dist, dist)
        for i in range(1, n - 1):
            dist = stones[i + 1] - stones[i - 1]
            max_dist = max(max_dist, dist)
        return max_dist