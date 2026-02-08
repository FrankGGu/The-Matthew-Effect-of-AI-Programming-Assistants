class Solution:
    def putMarbles(self, weights: List[int], k: int) -> int:
        weights.sort()
        min_sum = sum(weights[i] + weights[-(i + 1)] for i in range(k - 1))
        max_sum = sum(weights[i] + weights[-(i + 1)] for i in range(len(weights) - k + 1, len(weights)))
        return max_sum - min_sum