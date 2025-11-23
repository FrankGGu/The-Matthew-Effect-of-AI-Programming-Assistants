class Solution:
    def signOfProduct(self, nums: List[int]) -> int:
        negative_count = 0
        for num in nums:
            if num == 0:
                return 0
            elif num < 0:
                negative_count += 1
        return -1 if negative_count % 2 else 1