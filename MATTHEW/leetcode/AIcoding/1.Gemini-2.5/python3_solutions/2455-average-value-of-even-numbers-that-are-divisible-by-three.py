class Solution:
    def averageValue(self, nums: list[int]) -> int:
        total_sum = 0
        count = 0
        for num in nums:
            if num % 2 == 0 and num % 3 == 0:
                total_sum += num
                count += 1

        if count == 0:
            return 0
        else:
            return total_sum // count