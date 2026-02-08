class Solution:
    def countAlternatingSubarrays(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)

        for i in range(n):
            if i < n - 1 and nums[i] + 1 == nums[i + 1]:
                j = i
                while j < n - 1 and nums[j] + 1 == nums[j + 1]:
                    j += 1
                count += (j - i + 1) * (j - i) // 2
                i = j

        return count