class Solution:
    def findLengthOfShortestSubarray(self, arr: list[int]) -> int:
        n = len(arr)

        # Find the longest non-decreasing prefix
        # `left` will be the index of the last element of this prefix.
        left = 0
        while left + 1 < n and arr[left] <= arr[left+1]:
            left += 1

        # If the entire array is already sorted, no removal is needed.
        if left == n - 1:
            return 0

        # Find the longest non-decreasing suffix
        # `right` will be the index of the first element of this suffix.
        right = n - 1
        while right - 1 >= 0 and arr[right-1] <= arr[right]:
            right -= 1

        # Initialize the minimum length to remove.
        # Two initial candidates:
        # 1. Remove the suffix starting from `left + 1`. Remaining is `arr[0...left]`.
        #    Length to remove: `n - (left + 1)`.
        # 2. Remove the prefix ending at `right - 1`. Remaining is `arr[right...n-1]`.
        #    Length to remove: `right`.
        ans = min(n - (left + 1), right)

        # Now, consider combining a prefix `arr[0...i]` and a suffix `arr[j...n-1]`.
        # `i` must be within the sorted prefix: `0 <= i <= left`.
        # `j` must be within the sorted suffix: `right <= j <= n-1`.
        # Also, `i < j` and `arr[i] <= arr[j]` must hold.

        j_ptr = right # Initialize suffix pointer to the start of the sorted suffix

        # Iterate through all possible ending points `i` of the prefix.
        for i in range(left + 1): # `i` goes from 0 to `left` (inclusive)
            # Advance `j_ptr` to find the smallest `j` such that:
            # 1. `j` is a valid index (`j_ptr < n`).
            # 2. `arr[j]` is greater than or equal to `arr[i]` (`arr[i] <= arr[j_ptr]`).
            # 3. `j` is strictly greater than `i` (`j_ptr > i`).
            # The `j_ptr <= i` condition in the while loop handles the `j_ptr > i` requirement.
            while j_ptr < n and (arr[i] > arr[j_ptr] or j_ptr <= i):
                j_ptr += 1

            # If a valid `j_ptr` is found (i.e., `j_ptr` is still within bounds):
            # The removed subarray is `arr[i+1 ... j_ptr-1]`.
            # Its length is `(j_ptr - 1) - (i + 1) + 1 = j_ptr - i - 1`.
            if j_ptr < n:
                ans = min(ans, j_ptr - i - 1)
            else:
                # If `j_ptr` has reached `n`, it means no valid suffix could be found
                # for the current `arr[i]` (or any larger `arr[i]` in subsequent iterations).
                # So, we can break early.
                break

        return ans