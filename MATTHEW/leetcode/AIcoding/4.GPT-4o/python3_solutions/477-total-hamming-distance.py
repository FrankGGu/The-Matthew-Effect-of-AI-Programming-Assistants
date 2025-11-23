class Solution:
    def totalHammingDistance(self, nums: List[int]) -> int:
        total = 0
        n = len(nums)

        for i in range(32):
            count_one = sum((num >> i) & 1 for num in nums)
            count_zero = n - count_one
            total += count_one * count_zero

        return total