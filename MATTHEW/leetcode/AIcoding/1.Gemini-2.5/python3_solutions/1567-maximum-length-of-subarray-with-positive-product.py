class Solution:
    def getMaxLen(self, nums: list[int]) -> int:
        max_len = 0
        pos_len = 0  # length of subarray ending with a positive product
        neg_len = 0  # length of subarray ending with a negative product

        for num in nums:
            if num == 0:
                pos_len = 0
                neg_len = 0
            elif num > 0:
                pos_len += 1
                if neg_len > 0:
                    neg_len += 1
                else:
                    neg_len = 0
            else:  # num < 0
                # To avoid using updated pos_len/neg_len in the same iteration
                # we store their values before potential modification.
                prev_pos_len = pos_len
                prev_neg_len = neg_len

                # A new positive product subarray can be formed if there was a previous negative product subarray.
                # Multiplying a negative number with a negative product results in a positive product.
                if prev_neg_len > 0:
                    pos_len = prev_neg_len + 1
                else:
                    pos_len = 0  # A single negative number or multiplying with an empty/positive product doesn't yield positive.

                # A new negative product subarray can always be formed.
                # Multiplying a negative number with a positive product results in a negative product.
                # Or, if there was no positive product (prev_pos_len is 0), the current negative number itself forms a negative product subarray of length 1.
                neg_len = prev_pos_len + 1

            max_len = max(max_len, pos_len)

        return max_len