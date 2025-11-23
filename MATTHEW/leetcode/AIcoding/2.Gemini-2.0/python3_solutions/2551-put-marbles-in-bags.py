class Solution:
    def putMarbles(self, weights: list[int], k: int) -> int:
        n = len(weights)
        if k == 1 or k == n:
            return 0
        pairs = []
        for i in range(n - 1):
            pairs.append(weights[i] + weights[i + 1])
        pairs.sort()
        min_score = sum(pairs[:k - 1])
        max_score = sum(pairs[n - k:])
        return max_score - min_score