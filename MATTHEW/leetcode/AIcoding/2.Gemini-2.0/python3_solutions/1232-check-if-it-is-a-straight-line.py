class Solution:
    def checkStraightLine(self, coordinates: List[List[int]]) -> bool:
        if len(coordinates) <= 2:
            return True

        x0, y0 = coordinates[0]
        x1, y1 = coordinates[1]

        if x1 - x0 == 0:
            for i in range(2, len(coordinates)):
                if coordinates[i][0] - x0 != 0:
                    return False
            return True

        slope = (y1 - y0) / (x1 - x0)

        for i in range(2, len(coordinates)):
            x, y = coordinates[i]
            if x - x0 == 0:
                return False
            current_slope = (y - y0) / (x - x0)
            if current_slope != slope:
                return False

        return True