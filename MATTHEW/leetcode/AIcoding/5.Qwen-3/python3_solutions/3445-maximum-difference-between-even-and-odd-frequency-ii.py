class Solution:
    def maximumOddEven(self, nums: List[int]) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        for num in nums:
            freq[num] += 1

        max_diff = 0
        for key in freq:
            for other in freq:
                if (key % 2 == 1 and other % 2 == 0) or (key % 2 == 0 and other % 2 == 1):
                    diff = abs(freq[key] - freq[other])
                    if diff > max_diff:
                        max_diff = diff

        return max_diff