var minimumCost = function(start, target, specialRoads) {
    const [x1, y1] = start;
    const [x2, y2] = target;
    const pq = new MinPriorityQueue({ priority: (node) => node.cost });
    const visited = new Map();

    pq.enqueue({ x: x1, y: y1, cost: 0 });
    visited.set(`${x1},${y1}`, 0);

    while (!pq.isEmpty()) {
        const { x, y, cost } = pq.dequeue().element;

        if (x === x2 && y === y2) {
            return cost;
        }

        if (cost > (visited.get(`${x},${y}`) || Infinity)) {
            continue;
        }

        for (const [a, b, c, d, roadCost] of specialRoads) {
            const newCost = cost + Math.abs(x - a) + Math.abs(y - b) + roadCost;
            const key = `${c},${d}`;
            if (!visited.has(key) || newCost < visited.get(key)) {
                visited.set(key, newCost);
                pq.enqueue({ x: c, y: d, cost: newCost });
            }
        }

        const directCost = cost + Math.abs(x - x2) + Math.abs(y - y2);
        const key = `${x2},${y2}`;
        if (!visited.has(key) || directCost < visited.get(key)) {
            visited.set(key, directCost);
            pq.enqueue({ x: x2, y: y2, cost: directCost });
        }
    }

    return -1;
};