class Solution:
    def tupleSameProduct(self, nums: List[int]) -> int:
        product_count = {}
        n = len(nums)
        res = 0

        for i in range(n):
            for j in range(i + 1, n):
                product = nums[i] * nums[j]
                if product in product_count:
                    res += product_count[product]
                    product_count[product] += 1
                else:
                    product_count[product] = 1

        return res * 8