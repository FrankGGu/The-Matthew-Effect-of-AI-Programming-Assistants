class Solution:
    def countLatticePoints(self, circles: list[list[int]]) -> int:
        unique_points = set()

        for xi, yi, ri in circles:
            for x in range(xi - ri, xi + ri + 1):
                for y in range(yi - ri, yi + ri + 1):
                    if (x - xi)**2 + (y - yi)**2 <= ri**2:
                        unique_points.add((x, y))

        return len(unique_points)