class Solution:
    def minSwaps(self, nums: list[int]) -> int:
        n = len(nums)

        # Step 1: Count the total number of 1's
        total_ones = sum(nums)

        # Edge case: If there are no 1's or only one 1, no swaps are needed.
        if total_ones <= 1:
            return 0

        # Step 2: Create a circular array by duplicating nums
        # This allows us to handle circularity with a standard sliding window
        nums_circular = nums + nums

        # Step 3: Initialize variables for the sliding window
        # The window size will be equal to the total number of 1's
        window_size = total_ones

        # Calculate the number of 1's in the first window
        current_ones_in_window = sum(nums_circular[0:window_size])

        # Initialize max_ones_in_window with the first window's count
        max_ones_in_window = current_ones_in_window

        # Step 4: Slide the window across the circular array
        # We only need to slide n times to cover all unique starting positions
        for i in range(window_size, n + window_size):
            # Update the current window's 1's count
            # Subtract the element leaving the window and add the element entering the window
            current_ones_in_window += nums_circular[i] - nums_circular[i - window_size]

            # Update the maximum number of 1's found in any window
            max_ones_in_window = max(max_ones_in_window, current_ones_in_window)

        # Step 5: The minimum number of swaps is total_ones - max_ones_in_window
        # This is because we want to maximize the 1's within a window of size total_ones.
        # The remaining (total_ones - max_ones_in_window) 1's must be brought into this window,
        # each requiring one swap with a 0 outside the window.
        return total_ones - max_ones_in_window