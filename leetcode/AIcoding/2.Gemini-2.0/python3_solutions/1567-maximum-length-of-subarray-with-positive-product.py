class Solution:
    def getMaxLen(self, nums: list[int]) -> int:
        pos = 0
        neg = 0
        ans = 0
        for num in nums:
            if num > 0:
                pos += 1
                neg = neg + 1 if neg > 0 else 0
            elif num < 0:
                new_pos = neg + 1 if neg > 0 else 0
                new_neg = pos + 1
                pos = new_pos
                neg = new_neg
            else:
                pos = 0
                neg = 0
            ans = max(ans, pos)
        return ans