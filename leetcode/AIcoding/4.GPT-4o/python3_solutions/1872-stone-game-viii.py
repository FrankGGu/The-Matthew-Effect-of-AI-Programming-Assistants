class Solution:
    def stoneGameVIII(self, stones: List[int]) -> int:
        n = len(stones)
        for i in range(1, n):
            stones[i] += stones[i - 1]
        max_score = stones[-1]
        result = max_score
        for i in range(n - 2, 0, -1):
            max_score = max(max_score, stones[i] - result)
            result = max(result, stones[i])
        return max_score