class Solution:
    def sumDigitDifferences(self, nums: list[int]) -> int:
        n = len(nums)
        total_sum = 0
        for i in range(n):
            for j in range(i + 1, n):
                s1 = str(nums[i])
                s2 = str(nums[j])
                min_digit1 = min(s1)
                max_digit1 = max(s1)
                min_digit2 = min(s2)
                max_digit2 = max(s2)
                total_sum += abs(int(max_digit1) - int(min_digit1)) + abs(int(max_digit2) - int(min_digit2))
        return total_sum