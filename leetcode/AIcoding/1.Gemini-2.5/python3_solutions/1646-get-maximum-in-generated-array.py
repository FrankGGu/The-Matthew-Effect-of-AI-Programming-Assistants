class Solution:
    def getMaximumGenerated(self, n: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return 1

        nums = [0] * (n + 1)
        nums[0] = 0
        nums[1] = 1

        max_val = 1

        for i in range(2, n + 1):
            if i % 2 == 0:  # i is even
                nums[i] = nums[i // 2]
            else:  # i is odd
                nums[i] = nums[i // 2] + nums[i // 2 + 1]
            max_val = max(max_val, nums[i])

        return max_val