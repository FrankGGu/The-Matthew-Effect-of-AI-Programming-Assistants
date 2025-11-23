import collections

class Solution:
    def tupleSameProduct(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 4:
            return 0

        product_counts = collections.defaultdict(int)

        for i in range(n):
            for j in range(i + 1, n):
                product = nums[i] * nums[j]
                product_counts[product] += 1

        total_tuples = 0

        for count in product_counts.values():
            if count >= 2:
                # If there are 'count' pairs (a, b) such that a * b = product,
                # we need to choose 2 distinct pairs from these 'count' pairs.
                # The number of ways to choose 2 pairs is count * (count - 1) / 2.
                # For each such choice of two pairs, say {a, b} and {c, d},
                # where a*b = c*d, we can form 8 distinct tuples:
                # (a, b, c, d), (a, b, d, c), (b, a, c, d), (b, a, d, c),
                # (c, d, a, b), (c, d, b, a), (d, c, a, b), (d, c, b, a).
                total_tuples += (count * (count - 1) // 2) * 8

        return total_tuples