class Solution:
    def numberOfWays(self, points: list[list[int]]) -> int:
        points.sort()
        n = len(points)
        count = 0
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                if points[i][1] > points[j][1]:
                    continue
                blocked = False
                for k in range(n):
                    if k == i or k == j:
                        continue
                    if points[i][0] <= points[k][0] <= points[j][0] and points[k][1] > points[i][1]:
                        blocked = True
                        break
                if not blocked:
                    count += 1
        return count