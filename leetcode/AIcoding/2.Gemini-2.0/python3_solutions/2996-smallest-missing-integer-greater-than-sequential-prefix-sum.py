class Solution:
    def missingInteger(self, nums: list[int]) -> int:
        n = len(nums)
        prefix_sum = nums[0]
        length = 1
        for i in range(1, n):
            if nums[i] == nums[i - 1] + 1:
                prefix_sum += nums[i]
                length += 1
            else:
                break

        s = set(nums)
        ans = prefix_sum
        while ans in s:
            ans += 1
        return ans