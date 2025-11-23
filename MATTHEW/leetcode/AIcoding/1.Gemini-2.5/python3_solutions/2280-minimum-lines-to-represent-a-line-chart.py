class Solution:
    def minimumLines(self, stockPrices: list[list[int]]) -> int:
        n = len(stockPrices)

        if n <= 1:
            return 0

        # Sort the stock prices by day to ensure consecutive points are considered in order.
        stockPrices.sort()

        # If there are at least two points, there's at least one line segment.
        lines = 1

        # Iterate from the third point to check for collinearity.
        # We need three points (p1, p2, p3) to check if p3 continues the line p1-p2.
        for i in range(2, n):
            p1 = stockPrices[i-2]
            p2 = stockPrices[i-1]
            p3 = stockPrices[i]

            # Calculate the differences in x and y coordinates for the two segments.
            # Segment 1: p1 to p2
            dx1 = p2[0] - p1[0]
            dy1 = p2[1] - p1[1]

            # Segment 2: p2 to p3
            dx2 = p3[0] - p2[0]
            dy2 = p3[1] - p2[1]

            # Check for collinearity using the cross-product method to avoid
            # floating-point issues and division by zero.
            # If (y2-y1)/(x2-x1) == (y3-y2)/(x3-x2), then (y2-y1)*(x3-x2) == (y3-y2)*(x2-x1).
            if dy1 * dx2 != dy2 * dx1:
                # If the slopes are different, a new line segment is required.
                lines += 1

        return lines