class Solution:
    def isGood(self, nums: List[int]) -> bool:
        n = max(nums)
        if len(nums) != n + 1:
            return False
        count = [0] * (n + 1)
        for num in nums:
            if num > n:
                return False
            count[num] += 1
            if num != n and count[num] > 1:
                return False
        return count[n] == 2