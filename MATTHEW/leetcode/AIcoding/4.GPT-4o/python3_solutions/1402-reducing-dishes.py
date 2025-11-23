class Solution:
    def maxSatisfaction(self, satisfaction: List[int]) -> int:
        satisfaction.sort()
        max_sum = 0
        current_sum = 0
        total_sum = 0

        for i in range(len(satisfaction) - 1, -1, -1):
            current_sum += satisfaction[i]
            total_sum += current_sum
            if total_sum < 0:
                break
            max_sum = max(max_sum, total_sum)

        return max_sum