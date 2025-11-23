class Solution:
    def numberOfSubarrays(self, nums: List[int], pattern: List[int]) -> int:
        n = len(nums)
        m = len(pattern)
        count = 0
        for i in range(n - m + 1):
            match = True
            for j in range(m):
                if nums[i + j] != pattern[j]:
                    match = False
                    break
            if match:
                count += 1
        return count