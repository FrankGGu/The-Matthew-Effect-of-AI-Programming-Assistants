class Solution:
    def leastBricks(self, wall: List[List[int]]) -> int:
        from collections import defaultdict

        gap_count = defaultdict(int)

        for row in wall:
            current_gap = 0
            for brick in row[:-1]:
                current_gap += brick
                gap_count[current_gap] += 1

        max_gaps = max(gap_count.values(), default=0)

        return len(wall) - max_gaps