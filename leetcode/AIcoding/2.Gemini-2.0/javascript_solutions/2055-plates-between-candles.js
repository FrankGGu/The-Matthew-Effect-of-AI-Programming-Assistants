var platesBetweenCandles = function(s, queries) {
    const n = s.length;
    const candlePositions = [];
    for (let i = 0; i < n; i++) {
        if (s[i] === '|') {
            candlePositions.push(i);
        }
    }

    const result = [];
    for (const query of queries) {
        const start = query[0];
        const end = query[1];

        let leftCandleIndex = -1;
        let rightCandleIndex = -1;

        let low = 0;
        let high = candlePositions.length - 1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (candlePositions[mid] >= start) {
                leftCandleIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        low = 0;
        high = candlePositions.length - 1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (candlePositions[mid] <= end) {
                rightCandleIndex = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (leftCandleIndex === -1 || rightCandleIndex === -1 || leftCandleIndex >= candlePositions.length || rightCandleIndex < 0 || leftCandleIndex > rightCandleIndex) {
            result.push(0);
        } else {
            const left = candlePositions[leftCandleIndex];
            const right = candlePositions[rightCandleIndex];
            let plates = right - left + 1 - (rightCandleIndex - leftCandleIndex + 1);
            result.push(Math.max(0, plates));
        }
    }

    return result;
};