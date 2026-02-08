class Solution:
    def countAlternatingSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        count = 0
        for i in range(n - 1):
            length = 2
            for j in range(i + 2, n):
                if nums[j] != nums[j-2]:
                    length += 1
                else:
                    break
            count += length - 1
        return count