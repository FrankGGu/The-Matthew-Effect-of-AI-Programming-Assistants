class Solution:
    def numberOfPoints(self, cars: list[list[int]]) -> int:

        covered_points = set()

        for start, end in cars:
            for point in range(start, end + 1):
                covered_points.add(point)

        return len(covered_points)