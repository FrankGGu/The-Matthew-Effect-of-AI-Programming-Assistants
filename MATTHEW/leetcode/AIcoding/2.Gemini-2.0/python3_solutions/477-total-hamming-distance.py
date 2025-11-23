class Solution:
    def totalHammingDistance(self, nums: List[int]) -> int:
        n = len(nums)
        total_distance = 0
        for i in range(32):
            count_zeros = 0
            count_ones = 0
            for num in nums:
                if (num >> i) & 1 == 0:
                    count_zeros += 1
                else:
                    count_ones += 1
            total_distance += count_zeros * count_ones
        return total_distance