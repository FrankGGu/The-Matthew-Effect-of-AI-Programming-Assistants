class Solution:
    def countAlternatingGroups(self, colors: list[int], k: int) -> int:
        n = len(colors)

        # Handle the base case where k=1. Any single element forms an alternating group of length 1.
        if k == 1:
            return n

        # Create an extended_colors array to handle circularity.
        # We need k-1 additional elements to check all windows of size k.
        extended_colors = colors + colors[:k-1]

        # Create a flag array where alternating_pairs_flags[i] is 1 if colors[i] != colors[i+1], else 0.
        # This array represents whether the pair starting at index i is alternating.
        # Its length will be n + k - 1 - 1 = n + k - 2.
        alternating_pairs_flags = []
        for i in range(len(extended_colors) - 1):
            if extended_colors[i] != extended_colors[i+1]:
                alternating_pairs_flags.append(1)
            else:
                alternating_pairs_flags.append(0)

        num_groups = 0

        # A group of k alternating colors requires k-1 alternating pairs.
        # We are looking for a window of k-1 consecutive 1s in alternating_pairs_flags.
        target_consecutive_ones = k - 1

        # Initialize the sum for the first window of target_consecutive_ones length.
        # This corresponds to the group starting at index 0 in the original colors array.
        current_window_sum = sum(alternating_pairs_flags[0:target_consecutive_ones])

        if current_window_sum == target_consecutive_ones:
            num_groups += 1

        # Slide the window across the alternating_pairs_flags array.
        # We need to check n starting positions for groups in the original colors array.
        # The loop iterates n-1 times for the remaining windows.
        for i in range(1, n):
            # Remove the leftmost element's contribution
            current_window_sum -= alternating_pairs_flags[i-1]
            # Add the rightmost element's contribution
            current_window_sum += alternating_pairs_flags[i + target_consecutive_ones - 1]

            if current_window_sum == target_consecutive_ones:
                num_groups += 1

        return num_groups