class Solution:
    def arraySign(self, nums: list[int]) -> int:
        neg_count = 0
        for num in nums:
            if num == 0:
                return 0
            if num < 0:
                neg_count += 1

        if neg_count % 2 == 0:
            return 1
        else:
            return -1