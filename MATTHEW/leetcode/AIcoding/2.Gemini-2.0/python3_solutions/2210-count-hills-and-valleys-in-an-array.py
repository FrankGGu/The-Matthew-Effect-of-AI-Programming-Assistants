class Solution:
    def countHillValley(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        count = 0
        i = 1
        while i < n - 1:
            if nums[i] == nums[i - 1]:
                i += 1
                continue

            j = i + 1
            while j < n and nums[j] == nums[i]:
                j += 1

            if j == n:
                break

            if (nums[i] > nums[i - 1] and nums[i] > nums[j]) or \
               (nums[i] < nums[i - 1] and nums[i] < nums[j]):
                count += 1

            i = j

        return count