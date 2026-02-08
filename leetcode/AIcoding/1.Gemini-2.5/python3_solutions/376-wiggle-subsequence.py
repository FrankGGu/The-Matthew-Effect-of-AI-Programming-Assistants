class Solution:
    def wiggleMaxLength(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 2:
            return n

        # up_len represents the length of the longest wiggle subsequence ending
        # with an increasing difference.
        up_len = 1
        # down_len represents the length of the longest wiggle subsequence ending
        # with a decreasing difference.
        down_len = 1

        for i in range(1, n):
            if nums[i] > nums[i-1]:
                # If current element is greater, it can extend a 'down' sequence
                # to an 'up' sequence.
                up_len = down_len + 1
            elif nums[i] < nums[i-1]:
                # If current element is smaller, it can extend an 'up' sequence
                # to a 'down' sequence.
                down_len = up_len + 1
            # If nums[i] == nums[i-1], it cannot extend either an 'up' or 'down'
            # sequence, so both up_len and down_len remain unchanged.
            # This is implicitly handled as they are not updated in this branch.

        return max(up_len, down_len)