class Solution:
    def minOperations(self, nums: List[int]) -> int:
        res = 0
        current_max = 0
        for num in nums:
            res += bin(num).count('1')
            current_max = max(current_max, num)
        if current_max > 0:
            res += len(bin(current_max)) - 3
        return res