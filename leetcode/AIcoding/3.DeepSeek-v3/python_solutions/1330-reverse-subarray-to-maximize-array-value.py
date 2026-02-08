class Solution:
    def maxValueAfterReverse(self, nums: List[int]) -> int:
        original_value = 0
        n = len(nums)
        for i in range(n - 1):
            original_value += abs(nums[i] - nums[i + 1])

        if n <= 2:
            return original_value

        max_gain = 0

        # Case 1: Reverse a prefix or suffix
        for i in range(n - 1):
            # Reverse from 0 to i
            gain = abs(nums[0] - nums[i + 1]) - abs(nums[i] - nums[i + 1])
            max_gain = max(max_gain, gain)
            # Reverse from i+1 to n-1
            gain = abs(nums[i] - nums[-1]) - abs(nums[i] - nums[i + 1])
            max_gain = max(max_gain, gain)

        # Case 2: Reverse a middle part
        max1 = -float('inf')
        min1 = float('inf')
        max2 = -float('inf')
        min2 = float('inf')

        for i in range(n - 1):
            a, b = nums[i], nums[i + 1]
            max1 = max(max1, min(a, b))
            min1 = min(min1, max(a, b))
            max2 = max(max2, max(a, b))
            min2 = min(min2, min(a, b))

        gain = 2 * (max1 - min1)
        max_gain = max(max_gain, gain)
        gain = 2 * (max2 - min2)
        max_gain = max(max_gain, gain)

        return original_value + max_gain