class Solution:
    def countPairs(self, nums: List[int], k: int) -> int:
        nums.sort()
        count = 0
        n = len(nums)

        j = 0
        for i in range(n):
            while j < n and nums[j] - nums[i] < k:
                j += 1
            count += j - i - 1

        return count