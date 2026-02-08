class Solution:
    def leastBricks(self, wall: List[List[int]]) -> int:
        gaps = {}
        for row in wall:
            curr = 0
            for i in range(len(row) - 1):
                curr += row[i]
                if curr not in gaps:
                    gaps[curr] = 0
                gaps[curr] += 1

        if not gaps:
            return len(wall)

        max_gaps = max(gaps.values())
        return len(wall) - max_gaps