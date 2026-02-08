var countPairs = function(points, k) {
    const freqMap = new Map();
    for (const [x, y] of points) {
        const key = `${x},${y}`;
        freqMap.set(key, (freqMap.get(key) || 0) + 1);
    }

    let ans = 0;

    for (const [x1, y1] of points) {
        const currentPointKey = `${x1},${y1}`;

        freqMap.set(currentPointKey, freqMap.get(currentPointKey) - 1);
        if (freqMap.get(currentPointKey) === 0) {
            freqMap.delete(currentPointKey);
        }

        for (let dx = 0; dx <= k; dx++) {
            const dy = k - dx;

            const targetKeys = new Set();
            targetKeys.add(`${x1 + dx},${y1 + dy}`);
            targetKeys.add(`${x1 + dx},${y1 - dy}`);
            targetKeys.add(`${x1 - dx},${y1 + dy}`);
            targetKeys.add(`${x1 - dx},${y1 - dy}`);

            for (const targetKey of targetKeys) {
                if (freqMap.has(targetKey)) {
                    ans += freqMap.get(targetKey);
                }
            }
        }

        freqMap.set(currentPointKey, (freqMap.get(currentPointKey) || 0) + 1);
    }

    return ans / 2;
};