int minimumLines(int** stockPrices, int stockPricesSize, int* stockPricesColSize) {
    if (stockPricesSize <= 1) {
        return 0;
    }

    // The problem statement guarantees that dayi (x-coordinates) are strictly increasing.
    // Therefore, the input array is already sorted by the x-coordinate, and no explicit sorting is needed.

    int lines = 1; // Start with 1 line for the first segment

    // Iterate through the points, checking for changes in slope between consecutive segments.
    // We need to compare the slope of (P_i-1, P_i) with (P_i, P_i+1).
    // This requires looking at three points at a time: stockPrices[i-1], stockPrices[i], stockPrices[i+1].
    // The loop runs from i = 1 to stockPricesSize - 2 to ensure valid indices for all three points.
    for (int i = 1; i < stockPricesSize - 1; ++i) {
        // Let P1 = stockPrices[i-1], P2 = stockPrices[i], P3 = stockPrices[i+1]
        // P1 = (x1, y1), P2 = (x2, y2), P3 = (x3, y3)

        // Calculate differences for the first segment (P1 to P2)
        long long dy1 = (long long)stockPrices[i][1] - stockPrices[i-1][1];
        long long dx1 = (long long)stockPrices[i][0] - stockPrices[i-1][0];

        // Calculate differences for the second segment (P2 to P3)
        long long dy2 = (long long)stockPrices[i+1][1] - stockPrices[i][1];
        long long dx2 = (long long)stockPrices[i+1][0] - stockPrices[i][0];

        // Check for collinearity using cross-multiplication to avoid division and floating-point issues.
        // Three points (x1, y1), (x2, y2), (x3, y3) are collinear if:
        // (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
        // This is equivalent to: dy1 * dx2 == dy2 * dx1
        // If they are not equal, the slope has changed, and a new line is needed.
        if (dy1 * dx2 != dy2 * dx1) {
            lines++;
        }
    }

    return lines;
}