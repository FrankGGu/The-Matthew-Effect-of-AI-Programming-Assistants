class Solution:
    def numberOfWays(self, points: list[list[int]]) -> int:
        points.sort()
        count = 0
        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                if points[j][1] >= points[i][1]:
                    valid = True
                    for k in range(len(points)):
                        if k != i and k != j and points[k][0] >= points[i][0] and points[k][0] <= points[j][0] and points[k][1] > points[i][1]:
                            valid = False
                            break
                    if valid:
                        count += 1
        return count