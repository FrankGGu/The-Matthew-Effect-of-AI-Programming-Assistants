var countPairs = function(points, k) {
    let count = 0;
    const freq = new Map();

    for (const [x, y] of points) {
        for (let i = 0; i <= k; i++) {
            const j = k - i;
            const targetX = x ^ i;
            const targetY = y ^ j;
            const key = `${targetX},${targetY}`;

            if (freq.has(key)) {
                count += freq.get(key);
            }
        }

        const key = `${x},${y}`;
        freq.set(key, (freq.get(key) || 0) + 1);
    }

    return count;
};