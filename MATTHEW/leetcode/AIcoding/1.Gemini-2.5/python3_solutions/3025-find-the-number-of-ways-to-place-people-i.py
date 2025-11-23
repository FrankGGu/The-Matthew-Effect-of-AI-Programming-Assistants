class Solution:
    def numberOfPairs(self, points: list[list[int]]) -> int:
        n = len(points)
        count = 0

        for i in range(n):
            for j in range(n):
                if i == j:
                    continue

                x1, y1 = points[i]
                x2, y2 = points[j]

                if x1 <= x2 and y1 >= y2:
                    count += 1

        return count