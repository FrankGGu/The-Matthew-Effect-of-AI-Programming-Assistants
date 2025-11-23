class Solution:
    def maxScoreSightseeingPair(self, values: List[int]) -> int:
        max_score = 0
        max_val_plus_idx = values[0] + 0
        for j in range(1, len(values)):
            max_score = max(max_score, max_val_plus_idx + values[j] - j)
            max_val_plus_idx = max(max_val_plus_idx, values[j] + j)
        return max_score