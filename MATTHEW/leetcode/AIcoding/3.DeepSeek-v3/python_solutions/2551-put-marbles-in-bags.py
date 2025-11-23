class Solution:
    def putMarbles(self, weights: List[int], k: int) -> int:
        if k == 1 or k == len(weights):
            return 0

        splits = []
        for i in range(len(weights) - 1):
            splits.append(weights[i] + weights[i + 1])

        splits.sort()

        min_sum = sum(splits[:k - 1])
        max_sum = sum(splits[-(k - 1):])

        return max_sum - min_sum