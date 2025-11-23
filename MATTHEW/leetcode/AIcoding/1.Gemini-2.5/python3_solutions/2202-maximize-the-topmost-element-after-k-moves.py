class Solution:
    def maximizeTheTopmostElement(self, nums: list[int], k: int) -> int:
        n = len(nums)

        if n == 0:
            return -1

        if k == 0:
            return nums[0]

        # Case: k is large enough to remove all elements or more
        # If k >= n:
        # We can remove all 'n' elements. This takes 'n' moves.
        # We have 'k - n' moves remaining.
        # The stack is empty, and all original elements are in the "removed" set.
        #
        # If (k - n) is odd:
        #   We have 'k - n' odd moves left. We use 1 move to add max(nums) back.
        #   We have 'k - n - 1' moves left, which is even and non-negative.
        #   We can use these even moves to remove and add max(nums) back, keeping it on top.
        #   So, max(nums) is a possible topmost element.
        #
        # If (k - n) is even:
        #   If k - n == 0 (i.e., k == n):
        #     We removed all 'n' elements. 0 moves left. Stack is empty. Cannot add anything back. Result -1.
        #     (This covers the special case of n=1, k=1: remove nums[0], stack empty, -1.)
        #   If k - n > 0:
        #     We have 'k - n' even moves left. We use 1 move to add max(nums) back.
        #     We have 'k - n - 1' moves left, which is odd and non-negative.
        #     We are forced to use the last odd move to remove max(nums). Stack becomes empty. Result -1.
        #
        # So, if k >= n:
        #   If (k - n) % 2 == 1: return max(nums)
        #   Else: return -1
        if k >= n:
            if (k - n) % 2 == 1:
                return max(nums)
            else:
                return -1

        # Case: 0 < k < n
        # This means we cannot remove all elements and leave the stack empty without further moves.
        # We can achieve the topmost element in two ways:
        # 1. The topmost element `nums[j]` was never removed and added back.
        #    This means we performed `j` removals from the top (`nums[0]` to `nums[j-1]`).
        #    `nums[j]` is now at the top. This took `j` moves.
        #    We have `k-j` moves remaining. These must be used in (remove, add) pairs on `nums[j]`
        #    to keep it on top. So `k-j` must be even.
        #    `j` can range from `0` to `k`. (Since `k < n`, `nums[j]` is always a valid index).
        #
        # 2. The topmost element `max(nums[0...i-1])` was removed and then added back.
        #    We remove `i` elements (`nums[0]` to `nums[i-1]`). This takes `i` moves.
        #    We then add one of these removed elements back to the top. This takes 1 move.
        #    Total moves used: `i+1`.
        #    We have `k - (i+1)` moves remaining. These must be even and non-negative
        #    to keep the chosen element on top.
        #    The element added back would be `max(nums[0...i-1])` to maximize.
        #    `i` can range from `1` to `k-1`. (Since `k < n`, `nums[i-1]` is always a valid index).

        max_val = -1

        # Possibility 1: nums[j] is the topmost element
        # j is the number of elements removed from the top.
        # The element at index j becomes the topmost.
        # This takes j moves. Remaining moves: k-j. Must be even.
        # j can range from 0 to k.
        for j in range(k + 1): # j goes from 0 up to k
            # Since k < n, j will always be < n, so nums[j] is a valid index.
            if (k - j) % 2 == 0:
                max_val = max(max_val, nums[j])

        # Possibility 2: An element from nums[0...i-1] is the topmost (removed and added back)
        # i is the number of elements removed from the top.
        # We remove nums[0]...nums[i-1]. This takes i moves.
        # We then add one of them back. This takes 1 move. Total i+1 moves.
        # Remaining moves: k - (i+1). Must be even and non-negative.
        # The element added back would be max(nums[0...i-1]).
        # i can range from 1 to k-1.
        current_max_in_removed_prefix = -1
        for i in range(1, k): # i goes from 1 up to k-1
            # nums[i-1] is the current element being added to the 'removed' set
            # current_max_in_removed_prefix stores max(nums[0]...nums[i-1])
            current_max_in_removed_prefix = max(current_max_in_removed_prefix, nums[i-1])

            if (k - (i + 1)) >= 0 and (k - (i + 1)) % 2 == 0:
                max_val = max(max_val, current_max_in_removed_prefix)

        return max_val