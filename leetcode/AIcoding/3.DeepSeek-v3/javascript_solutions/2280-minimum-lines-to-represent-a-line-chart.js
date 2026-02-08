var minimumLines = function(stockPrices) {
    if (stockPrices.length <= 1) return 0;
    stockPrices.sort((a, b) => a[0] - b[0]);
    let lines = 0;
    let prevSlope = null;

    for (let i = 1; i < stockPrices.length; i++) {
        const [x1, y1] = stockPrices[i - 1];
        const [x2, y2] = stockPrices[i];
        const dx = x2 - x1;
        const dy = y2 - y1;
        const currentSlope = BigInt(dy) * BigInt(prevSlope ? prevSlope[1] : 1);
        const prevSlopeValue = BigInt(prevSlope ? prevSlope[0] : dy) * BigInt(prevSlope ? prevSlope[1] : dx);

        if (currentSlope !== prevSlopeValue) {
            lines++;
            prevSlope = [dy, dx];
        }
    }

    return lines;
};