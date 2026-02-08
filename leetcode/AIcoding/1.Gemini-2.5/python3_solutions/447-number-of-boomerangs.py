import collections

class Solution:
    def numberOfBoomerangs(self, points: list[list[int]]) -> int:
        count = 0
        for i in range(len(points)):
            distances = collections.defaultdict(int)
            for j in range(len(points)):
                if i == j:
                    continue

                dx = points[i][0] - points[j][0]
                dy = points[i][1] - points[j][1]
                dist_sq = dx*dx + dy*dy
                distances[dist_sq] += 1

            for d_count in distances.values():
                count += d_count * (d_count - 1)

        return count