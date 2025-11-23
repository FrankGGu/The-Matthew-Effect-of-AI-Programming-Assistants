var platesBetweenCandles = function(s, queries) {
    const n = s.length;
    const candleIndices = [];
    for (let i = 0; i < n; i++) {
        if (s[i] === '|') {
            candleIndices.push(i);
        }
    }

    const prefixPlates = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixPlates[i + 1] = prefixPlates[i] + (s[i] === '*' ? 1 : 0);
    }

    const findFirstCandleIndex = (arr, target) => {
        let low = 0, high = arr.length - 1;
        let ans_idx = arr.length; 
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (arr[mid] >= target) {
                ans_idx = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans_idx;
    };

    const findLastCandleIndex = (arr, target) => {
        let low = 0, high = arr.length - 1;
        let ans_idx = -1; 
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (arr[mid] <= target) {
                ans_idx = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans_idx;
    };

    const results = [];
    for (const query of queries) {
        const [left, right] = query;

        const idx_first_candle_in_ci = findFirstCandleIndex(candleIndices, left);
        const idx_last_candle_in_ci = findLastCandleIndex(candleIndices, right);

        if (idx_first_candle_in_ci === candleIndices.length || 
            idx_last_candle_in_ci === -1 || 
            idx_first_candle_in_ci >= idx_last_candle_in_ci) {
            results.push(0);
        } else {
            const actualFirstCandlePos = candleIndices[idx_first_candle_in_ci];
            const actualLastCandlePos = candleIndices[idx_last_candle_in_ci];

            const platesCount = prefixPlates[actualLastCandlePos] - prefixPlates[actualFirstCandlePos + 1];
            results.push(platesCount);
        }
    }

    return results;
};