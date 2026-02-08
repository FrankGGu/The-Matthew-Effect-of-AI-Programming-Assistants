class Solution:
    def maxSatisfaction(self, satisfaction: list[int]) -> int:
        satisfaction.sort()
        n = len(satisfaction)
        max_sum = 0
        current_sum = 0
        total_sum = 0
        for i in range(n - 1, -1, -1):
            current_sum += satisfaction[i]
            total_sum += current_sum
            max_sum = max(max_sum, total_sum)
        return max_sum