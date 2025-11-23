class Solution:
    def numberOfPairs(self, points: List[List[int]]) -> int:
        points.sort(key=lambda x: (x[0], -x[1]))
        count = 0
        n = len(points)
        for i in range(n):
            x1, y1 = points[i]
            for j in range(i + 1, n):
                x2, y2 = points[j]
                if y2 > y1:
                    continue
                valid = True
                for k in range(n):
                    x, y = points[k]
                    if x1 <= x <= x2 and y2 <= y <= y1 and (x, y) != (x1, y1) and (x, y) != (x2, y2):
                        valid = False
                        break
                if valid:
                    count += 1
        return count