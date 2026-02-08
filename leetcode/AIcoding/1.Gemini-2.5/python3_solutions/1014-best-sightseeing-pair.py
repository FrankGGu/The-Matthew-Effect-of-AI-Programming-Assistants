class Solution:
    def maxScoreSightseeingPair(self, values: list[int]) -> int:
        n = len(values)

        max_val_i_plus_i = values[0] + 0 
        max_score = float('-inf') 

        for j in range(1, n):
            current_score = max_val_i_plus_i + (values[j] - j)
            max_score = max(max_score, current_score)
            max_val_i_plus_i = max(max_val_i_plus_i, values[j] + j)

        return max_score