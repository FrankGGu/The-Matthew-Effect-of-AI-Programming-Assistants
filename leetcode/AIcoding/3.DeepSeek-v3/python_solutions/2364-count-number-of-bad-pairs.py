class Solution:
    def countBadPairs(self, nums: List[int]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        total = 0
        n = len(nums)
        for i in range(n):
            key = nums[i] - i
            total += i - count[key]
            count[key] += 1
        return total