class Solution:
    def countAlmostEqualPairs(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                if abs(nums[i] - nums[j]) <= 2:
                    count += 1
        return count