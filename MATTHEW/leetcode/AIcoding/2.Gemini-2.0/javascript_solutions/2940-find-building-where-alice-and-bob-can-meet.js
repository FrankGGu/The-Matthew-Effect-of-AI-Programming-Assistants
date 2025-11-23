var findBuildings = function(heights, queries) {
    const n = heights.length;
    const m = queries.length;
    const result = new Array(m);

    for (let i = 0; i < m; i++) {
        const a = queries[i][0];
        const b = queries[i][1];
        let low = -1;
        let high = n;

        while (low + 1 < high) {
            const mid = Math.floor((low + high) / 2);
            if (heights[mid] >= Math.min(heights[a], heights[b])) {
                let canReachA = true;
                for (let j = Math.min(a, mid) + 1; j <= Math.max(a, mid); j++) {
                    if (heights[j] > heights[a]) {
                        canReachA = false;
                        break;
                    }
                }

                let canReachB = true;
                for (let j = Math.min(b, mid) + 1; j <= Math.max(b, mid); j++) {
                    if (heights[j] > heights[b]) {
                        canReachB = false;
                        break;
                    }
                }

                if (canReachA && canReachB) {
                    high = mid;
                } else {
                    low = mid;
                }
            } else {
                low = mid;
            }
        }

        result[i] = high === n ? -1 : high;
    }

    return result;
};