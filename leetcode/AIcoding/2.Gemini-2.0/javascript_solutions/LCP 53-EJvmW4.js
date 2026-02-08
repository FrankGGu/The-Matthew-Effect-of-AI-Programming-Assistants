var defendSpaceCity = function(start, end, cost) {
    const n = start.length;
    const events = [];
    for (let i = 0; i < n; i++) {
        events.push([start[i], 0, i]); 
        events.push([end[i] + 1, 1, i]);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    let totalCost = 0;
    const active = new Map();

    for (const [time, type, index] of events) {
        if (type === 0) {
            active.set(index, cost[index]);
        } else {
            active.delete(index);
        }

        if (active.size > 0) {
            let minCost = Infinity;
            let minIndex = -1;
            for (const [idx, c] of active) {
                if (c < minCost) {
                    minCost = c;
                    minIndex = idx;
                }
            }
            totalCost += minCost;
            active.delete(minIndex);
        }
    }

    return totalCost;
};