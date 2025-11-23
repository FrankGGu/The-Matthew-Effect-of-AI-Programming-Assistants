class Solution:
    def countAlternatingSubarrays(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i, n):
                if j == i:
                    count += 1
                else:
                    if nums[j] != nums[j-1]:
                        count += 1
                    else:
                        break
        return count