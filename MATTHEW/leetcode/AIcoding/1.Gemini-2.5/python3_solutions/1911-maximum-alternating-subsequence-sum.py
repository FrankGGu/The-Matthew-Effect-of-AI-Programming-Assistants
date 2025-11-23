class Solution:
    def maxAlternatingSum(self, nums: list[int]) -> int:
        # add_val represents the maximum alternating sum ending with a positive term.
        # This means the last chosen element was added.
        # sub_val represents the maximum alternating sum ending with a negative term.
        # This means the last chosen element was subtracted.

        # Initialize with 0.
        # An empty subsequence has a sum of 0.
        # If we start a subsequence with nums[i], it's effectively 0 + nums[i].
        # If we subtract nums[i], it's effectively 0 - nums[i] (which we want to avoid if possible).
        add_val = 0
        sub_val = 0

        for num in nums:
            # When considering the current 'num':
            # 1. To update add_val:
            #    We can either not include 'num' and keep the previous max_add_val,
            #    OR we can include 'num' by adding it to a previous sub_val.
            #    (e.g., ... - X + num)
            #    We also implicitly handle starting a new subsequence with 'num' (0 + num).
            new_add_val = max(add_val, sub_val + num)

            # 2. To update sub_val:
            #    We can either not include 'num' and keep the previous max_sub_val,
            #    OR we can include 'num' by subtracting it from a previous add_val.
            #    (e.g., ... + X - num)
            new_sub_val = max(sub_val, add_val - num)

            add_val = new_add_val
            sub_val = new_sub_val

        # The maximum alternating subsequence sum must end with an addition
        # (or be a single element which is an addition).
        # For example, A - B + C. The last operation is +C.
        # If it were A - B, this is equivalent to A - B + 0, which is not what we are looking for.
        # The problem defines sum as nums[i0] - nums[i1] + nums[i2] - ...
        # So the first term is always added. Thus, the final sum is always `add_val`.
        return add_val