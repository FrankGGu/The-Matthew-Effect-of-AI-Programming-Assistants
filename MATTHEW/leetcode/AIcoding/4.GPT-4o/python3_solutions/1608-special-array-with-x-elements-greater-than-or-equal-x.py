class Solution:
    def specialArray(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        for x in range(n + 1):
            if n - bisect.bisect_left(nums, x) == x:
                return x
        return -1