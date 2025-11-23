class Solution:
    def missingInteger(self, nums: list[int]) -> int:
        n = len(nums)

        prefix_sum = nums[0]
        for i in range(1, n):
            if nums[i] == nums[i-1] + 1:
                prefix_sum += nums[i]
            else:
                break

        num_set = set(nums)

        x = prefix_sum
        while x in num_set:
            x += 1

        return x