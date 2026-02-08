class Solution:
    def sumDigitDifferences(self, nums: List[int]) -> int:
        total = 0
        max_len = len(str(max(nums)))
        for d in range(max_len):
            count = [0] * 10
            for num in nums:
                digit = (num // (10 ** d)) % 10
                count[digit] += 1
            for i in range(10):
                for j in range(i + 1, 10):
                    total += count[i] * count[j]
        return total