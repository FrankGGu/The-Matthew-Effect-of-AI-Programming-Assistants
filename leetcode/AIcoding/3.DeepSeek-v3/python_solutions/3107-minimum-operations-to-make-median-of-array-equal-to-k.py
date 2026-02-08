class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        nums.sort()
        n = len(nums)
        median_pos = n // 2
        operations = 0

        for i in range(median_pos, n):
            if nums[i] < k:
                operations += k - nums[i]

        return operations