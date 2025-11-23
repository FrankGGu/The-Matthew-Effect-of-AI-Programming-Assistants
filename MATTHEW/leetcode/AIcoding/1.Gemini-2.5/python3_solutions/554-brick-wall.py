import collections

class Solution:
    def leastBricks(self, wall: list[list[int]]) -> int:
        gap_counts = collections.Counter()

        for row in wall:
            current_length = 0
            for brick_length in row[:-1]: 
                current_length += brick_length
                gap_counts[current_length] += 1

        max_freq = max(gap_counts.values()) if gap_counts else 0

        return len(wall) - max_freq