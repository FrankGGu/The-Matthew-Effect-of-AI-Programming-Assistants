class Solution:
    def maxFactorScore(self, nums: List[int]) -> int:
        from collections import defaultdict
        factor_count = defaultdict(int)
        for num in nums:
            for i in range(1, int(num**0.5) + 1):
                if num % i == 0:
                    factor_count[i] += 1
                    if i != num // i:
                        factor_count[num // i] += 1
        return max(factor_count.values(), default=0)