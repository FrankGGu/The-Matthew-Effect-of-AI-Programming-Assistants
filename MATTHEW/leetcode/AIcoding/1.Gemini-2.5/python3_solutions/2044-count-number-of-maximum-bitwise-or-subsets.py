class Solution:
    def countMaxOrSubsets(self, nums: list[int]) -> int:
        max_or_val = 0
        for num in nums:
            max_or_val |= num

        count = 0
        n = len(nums)

        for i in range(1, 1 << n):
            current_or = 0
            for j in range(n):
                if (i >> j) & 1:
                    current_or |= nums[j]

            if current_or == max_or_val:
                count += 1

        return count