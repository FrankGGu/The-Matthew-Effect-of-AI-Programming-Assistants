class Solution:
    def numberOfPairs(self, points: List[List[int]]) -> int:
        points.sort(key=lambda x: (x[0], -x[1]))
        count = 0
        n = len(points)
        for i in range(n):
            x1, y1 = points[i]
            max_y = -float('inf')
            for j in range(i + 1, n):
                x2, y2 = points[j]
                if y2 <= y1 and y2 > max_y:
                    valid = True
                    for k in range(i + 1, j):
                        xk, yk = points[k]
                        if yk >= y2 and yk <= y1:
                            valid = False
                            break
                    if valid:
                        count += 1
                        max_y = y2
        return count