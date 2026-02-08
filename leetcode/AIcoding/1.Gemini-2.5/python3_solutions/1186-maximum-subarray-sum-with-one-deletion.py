import math

class Solution:
    def maximumSum(self, arr: list[int]) -> int:
        n = len(arr)

        # dp_no_del: maximum subarray sum ending at current index without any deletion.
        # dp_one_del: maximum subarray sum ending at current index with exactly one deletion.

        # Initialize for the first element
        # A subarray ending at index 0 without deletion is just arr[0].
        prev_no_del = arr[0]

        # A subarray ending at index 0 with one deletion is tricky.
        # If we delete arr[0], the subarray becomes empty, which is not allowed.
        # So, we initialize it to negative infinity to ensure it's not chosen
        # unless a valid deletion has occurred in a longer subarray.
        prev_one_del = float('-inf') 

        # The overall maximum sum found so far. Initialize with arr[0] as a single element
        # is a valid non-empty subarray.
        max_so_far = arr[0]

        # Iterate from the second element
        for i in range(1, n):
            # Calculate current_one_del for the current index i:
            # Option 1: Extend a previous subarray that already had one deletion by adding arr[i].
            #           (prev_one_del + arr[i])
            # Option 2: Delete arr[i] itself. In this case, the sum comes from the maximum subarray
            #           ending at i-1 without any deletion.
            #           (prev_no_del)
            current_one_del = max(prev_one_del + arr[i], prev_no_del)

            # Calculate current_no_del for the current index i:
            # This is standard Kadane's algorithm logic.
            # Option 1: Start a new subarray with arr[i].
            #           (arr[i])
            # Option 2: Extend the previous subarray without deletion by adding arr[i].
            #           (prev_no_del + arr[i])
            current_no_del = max(arr[i], prev_no_del + arr[i])

            # Update the overall maximum sum found.
            # It can be from a subarray with no deletion ending at i,
            # or from a subarray with one deletion ending at i.
            max_so_far = max(max_so_far, current_no_del, current_one_del)

            # Update previous values for the next iteration
            prev_no_del = current_no_del
            prev_one_del = current_one_del

        return max_so_far