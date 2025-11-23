function minimumCost(target, start, end, specialRoads) {
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const dist = new Map();
    const pq = [];

    const getKey = (x, y) => `${x},${y}`;
    const getDistance = (x1, y1, x2, y2) => Math.abs(x1 - x2) + Math.abs(y1 - y2);

    dist.set(getKey(start[0], start[1]), 0);
    pq.push([0, start[0], start[1]]);

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [cost, x, y] = pq.shift();

        if (x === end[0] && y === end[1]) return cost;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            const key = getKey(nx, ny);
            const newCost = cost + 1;

            if (!dist.has(key) || newCost < dist.get(key)) {
                dist.set(key, newCost);
                pq.push([newCost, nx, ny]);
            }
        }

        for (const [x1, y1, x2, y2, c] of specialRoads) {
            const key1 = getKey(x1, y1);
            const key2 = getKey(x2, y2);
            const cost1 = cost + getDistance(x, y, x1, y1) + c;
            const cost2 = cost + getDistance(x, y, x2, y2) + c;

            if (!dist.has(key1) || cost1 < dist.get(key1)) {
                dist.set(key1, cost1);
                pq.push([cost1, x1, y1]);
            }

            if (!dist.has(key2) || cost2 < dist.get(key2)) {
                dist.set(key2, cost2);
                pq.push([cost2, x2, y2]);
            }
        }
    }

    return -1;
}