class Solution:
    def arraySign(self, nums: List[int]) -> int:
        product_sign = 1
        for num in nums:
            if num == 0:
                return 0
            elif num < 0:
                product_sign *= -1
        return product_sign