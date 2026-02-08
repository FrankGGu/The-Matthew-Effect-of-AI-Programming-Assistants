from bisect import bisect_left

class Solution:
    def maximizeWin(self, prizes: list[int], k: int) -> int:
        n = len(prizes)
        if n == 0:
            return 0

        # Step 1: Calculate wins[i] for each segment starting at prizes[i]
        # wins[i] = number of prizes in [prizes[i], prizes[i] + k]
        wins = [0] * n
        right_ptr = 0
        for left_ptr in range(n):
            while right_ptr < n and prizes[right_ptr] <= prizes[left_ptr] + k:
                right_ptr += 1
            wins[left_ptr] = right_ptr - left_ptr

        # Step 2: Calculate max_prefix_wins[i] = max(wins[0], ..., wins[i])
        max_prefix_wins = [0] * n
        max_prefix_wins[0] = wins[0]
        for i in range(1, n):
            max_prefix_wins[i] = max(max_prefix_wins[i-1], wins[i])

        # Step 3: Calculate max_suffix_wins[i] = max(wins[i], ..., wins[n-1])
        max_suffix_wins = [0] * n
        max_suffix_wins[n-1] = wins[n-1]
        for i in range(n - 2, -1, -1):
            max_suffix_wins[i] = max(max_suffix_wins[i+1], wins[i])

        # Step 4: Initialize max_total_wins with the maximum from a single segment
        max_total_wins = max_prefix_wins[n-1] # This is max(wins)

        # Step 5: Iterate through each prize as the start of the first segment
        # and find the best second segment (disjoint)
        for i in range(n):
            current_segment_wins = wins[i]

            # Case A: Second segment is entirely to the left of the current segment
            # We need max(wins[j]) for j such that prizes[j] + k < prizes[i]
            # This means prizes[j] < prizes[i] - k
            target_val_left = prizes[i] - k
            # Find the largest index `idx_left` such that prizes[idx_left] < target_val_left
            idx_left = bisect_left(prizes, target_val_left) - 1
            if idx_left >= 0:
                max_total_wins = max(max_total_wins, current_segment_wins + max_prefix_wins[idx_left])

            # Case B: Second segment is entirely to the right of the current segment
            # We need max(wins[j]) for j such that prizes[j] > prizes[i] + k
            # This means prizes[j] >= prizes[i] + k + 1
            target_val_right = prizes[i] + k + 1
            # Find the smallest index `idx_right` such that prizes[idx_right] >= target_val_right
            idx_right = bisect_left(prizes, target_val_right)
            if idx_right < n:
                max_total_wins = max(max_total_wins, current_segment_wins + max_suffix_wins[idx_right])

        return max_total_wins