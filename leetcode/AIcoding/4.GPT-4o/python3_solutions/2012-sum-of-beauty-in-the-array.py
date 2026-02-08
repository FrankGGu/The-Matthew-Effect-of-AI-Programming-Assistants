class Solution:
    def sumOfBeauty(self, nums: List[int]) -> int:
        n = len(nums)
        left_min = [0] * n
        left_max = [0] * n
        right_min = [0] * n
        right_max = [0] * n

        left_min[0] = nums[0]
        left_max[0] = nums[0]
        for i in range(1, n):
            left_min[i] = min(left_min[i - 1], nums[i])
            left_max[i] = max(left_max[i - 1], nums[i])

        right_min[n - 1] = nums[n - 1]
        right_max[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            right_min[i] = min(right_min[i + 1], nums[i])
            right_max[i] = max(right_max[i + 1], nums[i])

        beauty_sum = 0
        for i in range(1, n - 1):
            if nums[i] < left_min[i - 1] or nums[i] > left_max[i - 1]:
                beauty_sum += 1
            if nums[i] < right_min[i + 1] or nums[i] > right_max[i + 1]:
                beauty_sum += 1

        return beauty_sum