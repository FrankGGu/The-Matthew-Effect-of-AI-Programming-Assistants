from collections import defaultdict
from itertools import combinations

class Solution:
    def tupleSameProduct(self, nums):
        product_count = defaultdict(int)
        count = 0

        for i, j in combinations(range(len(nums)), 2):
            product = nums[i] * nums[j]
            product_count[product] += 1

        for v in product_count.values():
            count += v * (v - 1) * 4

        return count