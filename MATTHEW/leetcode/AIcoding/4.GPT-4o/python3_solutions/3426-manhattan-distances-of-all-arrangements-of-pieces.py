class Solution:
    def manhattanDistance(self, nums: List[int]) -> int:
        n = len(nums)
        total_distance = 0

        for i in range(n):
            for j in range(n):
                total_distance += abs(i - j) * abs(nums[i] - nums[j])

        return total_distance