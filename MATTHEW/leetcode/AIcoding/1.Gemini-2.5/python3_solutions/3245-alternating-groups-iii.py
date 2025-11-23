class Solution:
    def numberOfAlternatingGroups(self, colors: list[int], k: int) -> int:
        n = len(colors)

        # If k is 1, any group of length 1 is considered alternating.
        # There are n such groups (each single element).
        if k == 1:
            return n

        # To handle the circular nature of the array, we extend it.
        # We need to check k-1 pairs of adjacent elements for a group of length k.
        # For a group starting at index `i`, we check pairs `(i, i+1), (i+1, i+2), ..., (i+k-2, i+k-1)`.
        # To avoid modulo operations in the inner loop, we append the first `k-1` elements
        # of `colors` to the end of `colors`.
        # This allows us to check groups starting at `i` from `0` to `n-1`
        # using `extended_colors[i]` to `extended_colors[i+k-1]`.
        extended_colors = colors + colors[:k-1]

        # `is_alternating_flags[j]` will be 1 if `extended_colors[j]` != `extended_colors[j+1]`, else 0.
        # This array represents whether each pair of adjacent elements in `extended_colors` alternates.
        # Its length will be `len(extended_colors) - 1`.
        # `len(extended_colors) = n + k - 1`, so `len(is_alternating_flags) = n + k - 2`.
        is_alternating_flags = [0] * (n + k - 2)
        for i in range(len(extended_colors) - 1):
            if extended_colors[i] != extended_colors[i+1]:
                is_alternating_flags[i] = 1
            else:
                is_alternating_flags[i] = 0

        count = 0
        zeros_in_window = 0

        # Initialize the sliding window for the first `k-1` flags.
        # This window corresponds to the group starting at index 0.
        # The window covers `is_alternating_flags[0]` to `is_alternating_flags[k-2]`.
        for i in range(k - 1):
            if is_alternating_flags[i] == 0:
                zeros_in_window += 1

        # Slide the window across `n` possible starting positions.
        # `i` represents the starting index of the `k-1` flags window in `is_alternating_flags`.
        # This `i` also corresponds to the starting index of the group in the original `colors` array.
        for i in range(n):
            # If there are no zeros in the current window of `k-1` flags,
            # it means all pairs alternate, so the group is alternating.
            if zeros_in_window == 0:
                count += 1

            # Slide the window: remove the flag leaving the window.
            # This flag is `is_alternating_flags[i]`.
            if is_alternating_flags[i] == 0:
                zeros_in_window -= 1

            # Slide the window: add the flag entering the window.
            # This flag is `is_alternating_flags[i + k - 1]`.
            # This addition prepares the window for the next iteration (group starting at `i+1`).
            # We only add if `i` is not the last starting position (`n-1`),
            # because after the last position, there are no more groups to check.
            if i < n - 1:
                if is_alternating_flags[i + k - 1] == 0:
                    zeros_in_window += 1

        return count