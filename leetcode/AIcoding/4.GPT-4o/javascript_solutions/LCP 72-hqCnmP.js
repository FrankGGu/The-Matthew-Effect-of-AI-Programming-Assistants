var canCarry = function(capacity, trips) {
    const load = new Array(1001).fill(0);
    for (const [from, to, amount] of trips) {
        load[from] += amount;
        load[to] -= amount;
    }

    let currentLoad = 0;
    for (let i = 1; i <= 1000; i++) {
        currentLoad += load[i];
        if (currentLoad > capacity) return false;
    }
    return true;
};