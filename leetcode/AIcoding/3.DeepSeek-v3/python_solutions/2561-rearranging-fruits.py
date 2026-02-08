class Solution:
    def minCost(self, basket1: List[int], basket2: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for num in basket1:
            count[num] += 1
        for num in basket2:
            count[num] -= 1

        swaps = []
        for num in count:
            if count[num] % 2 != 0:
                return -1
            swaps.extend([num] * (abs(count[num]) // 2))

        swaps.sort()
        min_val = min(basket1 + basket2)
        res = 0
        for i in range(len(swaps) // 2):
            res += min(swaps[i], 2 * min_val)

        return res