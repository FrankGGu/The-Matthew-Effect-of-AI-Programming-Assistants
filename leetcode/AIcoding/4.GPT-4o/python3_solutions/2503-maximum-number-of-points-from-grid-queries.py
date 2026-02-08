class Solution:
    def maxPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        points.sort(key=lambda x: x[1])  # Sort by y-coordinate
        events = []
        for x, y in points:
            events.append((x, y))

        results = []
        for qx, qy in sorted(zip(queries, range(len(queries))), key=lambda x: x[0][1]):
            count = 0
            for x, y in events:
                if x <= qx and y <= qy:
                    count += 1
            results.append((count, qy))

        return [r[0] for r in sorted(results, key=lambda x: x[1])]