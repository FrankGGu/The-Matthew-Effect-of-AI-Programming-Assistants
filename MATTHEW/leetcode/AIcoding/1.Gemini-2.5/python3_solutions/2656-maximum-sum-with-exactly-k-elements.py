class Solution:
    def maximizeSum(self, nums: list[int], k: int) -> int:
        max_val = 0
        for num in nums:
            if num > max_val:
                max_val = num

        total_sum = 0
        for i in range(k):
            total_sum += (max_val + i)

        return total_sum