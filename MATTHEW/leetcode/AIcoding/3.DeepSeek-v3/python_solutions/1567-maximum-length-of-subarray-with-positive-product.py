class Solution:
    def getMaxLen(self, nums: List[int]) -> int:
        max_len = 0
        pos_len = 0
        neg_len = 0

        for num in nums:
            if num > 0:
                pos_len += 1
                neg_len = neg_len + 1 if neg_len > 0 else 0
            elif num < 0:
                new_pos_len = neg_len + 1 if neg_len > 0 else 0
                new_neg_len = pos_len + 1
                pos_len, neg_len = new_pos_len, new_neg_len
            else:
                pos_len = 0
                neg_len = 0
            max_len = max(max_len, pos_len)

        return max_len