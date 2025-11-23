class Solution:
    def minimumLines(self, stockPrices: List[List[int]]) -> int:
        if len(stockPrices) == 1:
            return 0
        stockPrices.sort()
        lines = 1
        for i in range(2, len(stockPrices)):
            x0, y0 = stockPrices[i-2]
            x1, y1 = stockPrices[i-1]
            x2, y2 = stockPrices[i]
            dx1 = x1 - x0
            dy1 = y1 - y0
            dx2 = x2 - x1
            dy2 = y2 - y1
            if dy1 * dx2 != dy2 * dx1:
                lines += 1
        return lines