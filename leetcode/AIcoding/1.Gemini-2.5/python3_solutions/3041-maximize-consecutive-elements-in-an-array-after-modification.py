import collections

class Solution:
    def maximizeConsecutive(self, nums: list[int]) -> int:
        if not nums:
            return 0

        # Sort unique elements to handle duplicates and make consecutive checks easier
        unique_nums = sorted(list(set(nums)))
        n = len(unique_nums)

        # Base cases for empty or single element array
        if n == 0:
            return 0
        if n == 1:
            return 1

        max_overall_len = 1

        # Sliding window approach
        left = 0
        # `mod_pos` stores the index of the element `unique_nums[k]`
        # such that `unique_nums[k+1] - unique_nums[k] == 2` in the current window.
        # This means `unique_nums[k]` is the left side of the gap that we are bridging
        # with our single modification.
        # If `mod_pos == -1`, no modification has been used in the current window.
        mod_pos = -1 

        for right in range(n):
            if right > 0:
                diff = unique_nums[right] - unique_nums[right-1]
                if diff == 1:
                    # No gap, current elements are consecutive.
                    pass
                elif diff == 2:
                    # Gap of 1 (e.g., ...x, x+2...). This requires a modification.
                    if mod_pos != -1: 
                        # A modification has already been used in the current window.
                        # To use a modification for this new gap, we must "undo" the previous modification.
                        # This means shrinking the window from `left` past the previous modification.
                        # The previous modification bridged the gap at `mod_pos`.
                        # So, the new `left` starts after `mod_pos`.
                        left = mod_pos + 1
                        # The current gap (at `right-1`) now becomes the single modification in the new window.
                        mod_pos = right - 1
                    else: 
                        # This is the first gap of size 2 encountered in the current window.
                        mod_pos = right - 1
                else: # diff > 2 (gap of 2 or more, e.g., ...x, x+3...)
                    # This gap is too large to bridge with a single modification.
                    # The current consecutive sequence is broken.
                    # Start a new window from the current `right` element.
                    left = right
                    mod_pos = -1 # Reset modification status for the new window.

            # Calculate the maximum length for the current window [left, right].
            if mod_pos == -1:
                # No modification has been used in this window.
                # The length is simply the count of elements in the consecutive sequence.
                # Example: [1,2,3], left=0, right=2. Length = 2-0+1 = 3.
                max_overall_len = max(max_overall_len, right - left + 1)
            else:
                # A modification has been used to bridge the gap at `mod_pos`.
                # We have two ways to form a consecutive sequence of maximum length:
                # 1. Modify `unique_nums[mod_pos+1]` to `unique_nums[mod_pos]+1`.
                #    The sequence starts at `unique_nums[left]` and ends at `unique_nums[mod_pos]+1`.
                #    Its length is `(unique_nums[mod_pos]+1) - unique_nums[left] + 1`.
                #    Simplified: `unique_nums[mod_pos] - unique_nums[left] + 2`.
                #    Example: [1,2,4,5], mod_pos=1 (gap between 2 and 4).
                #    Modify 4 to 3. Sequence [1,2,3]. Length = 2-0+2 = 3.
                len1 = unique_nums[mod_pos] - unique_nums[left] + 2
                max_overall_len = max(max_overall_len, len1)

                # 2. Modify `unique_nums[mod_pos]` to `unique_nums[mod_pos+1]-1`.
                #    The sequence starts at `unique_nums[mod_pos+1]-1` and ends at `unique_nums[right]`.
                #    Its length is `unique_nums[right] - (unique_nums[mod_pos+1]-1) + 1`.
                #    Simplified: `unique_nums[right] - unique_nums[mod_pos+1] + 2`.
                #    Example: [1,2,4,5], mod_pos=1 (gap between 2 and 4).
                #    Modify 2 to 3. Sequence [3,4,5]. Length = 3-2+2 = 3.
                len2 = unique_nums[right] - unique_nums[mod_pos+1] + 2
                max_overall_len = max(max_overall_len, len2)

        return max_overall_len