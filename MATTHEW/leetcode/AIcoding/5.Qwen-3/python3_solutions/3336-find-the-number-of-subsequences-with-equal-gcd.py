class Solution:
    def countSubsequencesWithEqualGCD(self, nums: List[int]) -> int:
        from collections import defaultdict
        import math

        n = len(nums)
        max_num = max(nums) if nums else 0
        freq = defaultdict(int)

        for num in nums:
            freq[num] += 1

        result = 0

        for g in range(1, max_num + 1):
            count = 0
            for multiple in range(g, max_num + 1, g):
                count += freq[multiple]
            if count >= 2:
                result += (1 << count) - 1 - count

        return result