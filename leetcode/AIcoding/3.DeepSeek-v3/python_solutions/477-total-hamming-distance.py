class Solution:
    def totalHammingDistance(self, nums: List[int]) -> int:
        total = 0
        n = len(nums)
        for i in range(32):
            count = 0
            for num in nums:
                count += (num >> i) & 1
            total += count * (n - count)
        return total