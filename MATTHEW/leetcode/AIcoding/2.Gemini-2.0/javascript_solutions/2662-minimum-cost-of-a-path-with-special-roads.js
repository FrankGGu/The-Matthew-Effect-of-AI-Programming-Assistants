var minimumCost = function(start, target, specialRoads) {
    const dist = new Map();
    dist.set(start.join(','), 0);
    const pq = [[0, start]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [cost, curr] = pq.shift();

        if (curr[0] === target[0] && curr[1] === target[1]) {
            return cost;
        }

        if (cost > (dist.get(curr.join(',')) || Infinity)) {
            continue;
        }

        const directCost = Math.abs(curr[0] - target[0]) + Math.abs(curr[1] - target[1]);
        if ((dist.get(target.join(',')) || Infinity) > cost + directCost) {
            dist.set(target.join(','), cost + directCost);
            pq.push([cost + directCost, target]);
        }

        for (const road of specialRoads) {
            const [x1, y1, x2, y2, c] = road;
            const newCost = cost + Math.abs(curr[0] - x1) + Math.abs(curr[1] - y1) + c;
            if ((dist.get([x2, y2].join(',')) || Infinity) > newCost) {
                dist.set([x2, y2].join(','), newCost);
                pq.push([newCost, [x2, y2]]);
            }
        }
    }

    return dist.get(target.join(',')) || 0;
};