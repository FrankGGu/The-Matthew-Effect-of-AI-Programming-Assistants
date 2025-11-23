class Solution:
    def numberOfBoomerangs(self, points: list[list[int]]) -> int:
        count = 0
        for i in range(len(points)):
            distances = {}
            for j in range(len(points)):
                if i != j:
                    dist = (points[i][0] - points[j][0]) ** 2 + (points[i][1] - points[j][1]) ** 2
                    if dist in distances:
                        distances[dist] += 1
                    else:
                        distances[dist] = 1
            for dist in distances:
                count += distances[dist] * (distances[dist] - 1)
        return count