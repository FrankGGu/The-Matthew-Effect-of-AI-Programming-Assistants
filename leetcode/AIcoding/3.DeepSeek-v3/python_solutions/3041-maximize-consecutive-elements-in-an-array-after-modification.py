class Solution:
    def minOperations(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        unique_nums = []
        prev = None
        for num in nums:
            if num != prev:
                unique_nums.append(num)
                prev = num
        m = len(unique_nums)
        res = n
        left = 0
        for right in range(m):
            while unique_nums[right] - unique_nums[left] >= n:
                left += 1
            res = min(res, n - (right - left + 1))
        return res