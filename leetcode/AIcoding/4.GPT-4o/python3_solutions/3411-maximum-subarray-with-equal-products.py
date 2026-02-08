class Solution:
    def maxEqualProducts(self, nums: List[int]) -> int:
        from collections import defaultdict
        product_count = defaultdict(int)
        max_length = 0

        for i in range(len(nums)):
            product = 1
            for j in range(i, len(nums)):
                product *= nums[j]
                product_count[product] += 1
                max_length = max(max_length, product_count[product])

        return max_length