class Solution:
    def smallestMissingNonNegativeInteger(self, nums: list[int], value: int) -> int:
        freq = [0] * value
        for num in nums:
            freq[num % value] += 1

        x = 0
        while True:
            remainder = x % value
            if freq[remainder] > 0:
                freq[remainder] -= 1
                x += 1
            else:
                return x