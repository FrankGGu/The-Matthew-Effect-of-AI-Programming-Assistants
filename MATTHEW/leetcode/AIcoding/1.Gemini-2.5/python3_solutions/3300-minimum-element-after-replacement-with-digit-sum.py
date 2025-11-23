class Solution:
    def minimumSum(self, nums: list[int]) -> int:
        min_digit_sum = float('inf')
        for num in nums:
            # Calculate the digital root of the number
            # For any positive integer n, its digital root is (n - 1) % 9 + 1
            digital_root = (num - 1) % 9 + 1
            min_digit_sum = min(min_digit_sum, digital_root)
        return min_digit_sum