class Solution:
    def leftRightDifference(self, nums: list[int]) -> list[int]:
        n = len(nums)

        left_sums = [0] * n
        current_left_sum = 0
        for i in range(n):
            left_sums[i] = current_left_sum
            current_left_sum += nums[i]

        answer = [0] * n
        current_right_sum = 0
        for i in range(n - 1, -1, -1):
            answer[i] = abs(left_sums[i] - current_right_sum)
            current_right_sum += nums[i]

        return answer