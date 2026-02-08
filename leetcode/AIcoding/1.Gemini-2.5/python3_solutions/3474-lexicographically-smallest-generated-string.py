class Solution:
    def getSmallestGeneratedString(self, n: int) -> str:
        if n == 0:
            return 'a'

        nums = [0] * (n + 1)

        nums[0] = 0
        if n >= 1:
            nums[1] = 1

        for i in range(1, n // 2 + 1):
            if 2 * i <= n:
                nums[2 * i] = nums[i]

            if 2 * i + 1 <= n:
                nums[2 * i + 1] = nums[i] + nums[i + 1]

        min_val = float('inf')
        for x in nums:
            min_val = min(min_val, x)

        return chr(ord('a') + min_val)