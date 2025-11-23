from collections import defaultdict

class Solution:
    def leastBricks(self, wall: list[list[int]]) -> int:
        width_count = defaultdict(int)
        for row in wall:
            width = 0
            for i in range(len(row) - 1):
                width += row[i]
                width_count[width] += 1

        if not width_count:
            return len(wall)

        max_count = max(width_count.values())
        return len(wall) - max_count