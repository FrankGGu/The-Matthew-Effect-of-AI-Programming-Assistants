class Solution:
    def sumOfDigitDifferences(self, nums: List[int]) -> int:
        total_sum = 0
        n = len(nums)

        for i in range(10):
            count = 0
            for num in nums:
                count += (num // 10**i) % 10

            total_sum += count * (n * (10**i) - count * (10**i))

        return total_sum