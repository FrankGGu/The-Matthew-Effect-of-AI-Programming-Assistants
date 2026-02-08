class Solution:
    def numPoints(self, points: list[list[int]], r: int) -> int:
        def dist_sq(p1, p2):
            return (p1[0] - p2[0])**2 + (p1[1] - p2[1])**2

        def find_circle(p1, p2):
            d_sq = dist_sq(p1, p2)
            if d_sq > 4 * r * r:
                return []

            d = d_sq**0.5
            mid = ((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2)
            h = (r**2 - d_sq / 4)**0.5

            x1 = mid[0] + h * (p2[1] - p1[1]) / d
            y1 = mid[1] - h * (p2[0] - p1[0]) / d
            x2 = mid[0] - h * (p2[1] - p1[1]) / d
            y2 = mid[1] + h * (p2[0] - p1[0]) / d

            return [(x1, y1), (x2, y2)]

        n = len(points)
        ans = 1
        for i in range(n):
            for j in range(i + 1, n):
                circles = find_circle(points[i], points[j])
                for center in circles:
                    count = 0
                    for k in range(n):
                        if dist_sq(points[k], center) <= r * r + 1e-6:
                            count += 1
                    ans = max(ans, count)

        for i in range(n):
            count = 0
            for k in range(n):
                if (points[i][0]-points[k][0])**2+(points[i][1]-points[k][1])**2 <= r*r + 1e-6:
                    count += 1
            ans = max(ans, count)

        return ans