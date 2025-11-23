class Solution:
    def totalHammingDistance(self, nums: list[int]) -> int:
        total_distance = 0
        n = len(nums)

        for i in range(31): 
            count_set_bits = 0
            for num in nums:
                if (num >> i) & 1:
                    count_set_bits += 1

            total_distance += count_set_bits * (n - count_set_bits)

        return total_distance