var closestEqualElements = function(arr, queries) {
    const n = arr.length;
    const m = queries.length;
    const result = new Array(m).fill(-1);

    for (let i = 0; i < m; i++) {
        const [left, right] = queries[i];
        let minDiff = Infinity;

        for (let j = left; j <= right; j++) {
            for (let k = j + 1; k <= right; k++) {
                if (arr[j] === arr[k]) {
                    minDiff = Math.min(minDiff, k - j);
                }
            }
        }

        if (minDiff !== Infinity) {
            result[i] = minDiff;
        }
    }

    return result;
};