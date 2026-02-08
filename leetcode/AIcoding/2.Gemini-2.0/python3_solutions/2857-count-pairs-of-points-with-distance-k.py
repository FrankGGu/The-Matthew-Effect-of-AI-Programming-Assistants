from collections import defaultdict

class Solution:
    def countPairs(self, coordinates: list[list[int]], k: int) -> int:
        count = 0
        point_counts = defaultdict(int)
        for x, y in coordinates:
            target_x = x ^ k
            for i in range(k + 1):
                target_y = y ^ (k - i)
                if (target_x, target_y) in point_counts:
                    count += point_counts[(target_x, target_y)]
            point_counts[(x, y)] += 1
        return count