var minimumLines = function(prices) {
    if (prices.length <= 1) {
        return 0;
    }

    prices.sort((a, b) => a[0] - b[0]);

    let lines = 1;

    for (let i = 2; i < prices.length; i++) {
        const p1 = prices[i - 2];
        const p2 = prices[i - 1];
        const p3 = prices[i];

        // Check collinearity using cross-product to avoid floating point issues:
        // (y2 - y1) * (x3 - x2) == (y3 - y2) * (x2 - x1)
        // If not collinear, a new line segment starts.
        if ((p2[1] - p1[1]) * (p3[0] - p2[0]) !== (p3[1] - p2[1]) * (p2[0] - p1[0])) {
            lines++;
        }
    }

    return lines;
};