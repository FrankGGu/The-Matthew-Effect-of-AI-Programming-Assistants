var countPairs = function(coordinates, k) {
    const map = new Map();
    let count = 0;

    for (const [x, y] of coordinates) {
        for (let a = 0; a <= k; a++) {
            const b = k - a;
            const targetX = x ^ a;
            const targetY = y ^ b;
            const key = `${targetX},${targetY}`;
            if (map.has(key)) {
                count += map.get(key);
            }
        }
        const key = `${x},${y}`;
        map.set(key, (map.get(key) || 0) + 1);
    }

    return count;
};