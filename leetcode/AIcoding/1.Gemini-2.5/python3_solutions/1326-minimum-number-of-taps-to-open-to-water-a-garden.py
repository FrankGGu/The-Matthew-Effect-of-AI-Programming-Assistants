class Solution:
    def minTaps(self, n: int, ranges: list[int]) -> int:
        max_reach_from_start_point = [0] * (n + 1)

        for i in range(n + 1):
            r = ranges[i]
            left = max(0, i - r)
            right = min(n, i + r)
            max_reach_from_start_point[left] = max(max_reach_from_start_point[left], right)

        taps = 0
        current_end = 0  # The rightmost point currently covered by selected taps
        farthest_end = 0 # The maximum rightmost point reachable from current_end with one more tap

        for i in range(n + 1):
            # Update farthest_end with the maximum reach possible from any point up to i
            farthest_end = max(farthest_end, max_reach_from_start_point[i])

            # If we have reached the end of the current tap's coverage
            # and haven't covered the entire garden yet, we need to open a new tap.
            if i == current_end:
                taps += 1
                current_end = farthest_end
                # If after opening a new tap, we still cannot extend coverage
                # beyond the current point, it's impossible to cover the garden.
                if current_end < i + 1:
                    return -1

            # If the entire garden is covered, return the number of taps
            if current_end >= n:
                return taps

        # If the loop finishes and the garden is not fully covered
        if current_end < n:
            return -1

        return taps