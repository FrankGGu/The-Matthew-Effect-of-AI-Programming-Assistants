class Solution:
    def sortedGcdPairs(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        from math import gcd
        from collections import defaultdict

        def get_gcd_pairs(nums):
            n = len(nums)
            pairs = []
            for i in range(n):
                for j in range(i + 1, n):
                    g = gcd(nums[i], nums[j])
                    pairs.append((g, nums[i], nums[j]))
            return pairs

        pairs = get_gcd_pairs(nums)
        pairs.sort()
        result = []
        for q in queries:
            k = q[0]
            target = q[1]
            count = 0
            for g, a, b in pairs:
                if g == target:
                    count += 1
                    if count == k:
                        result.append([a, b])
                        break
        return result