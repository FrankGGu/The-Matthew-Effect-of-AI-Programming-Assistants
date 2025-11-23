var carPooling = function(trips, capacity) {
    const diff = new Array(1001).fill(0);

    for (const [num, start, end] of trips) {
        diff[start] += num;
        diff[end] -= num;
    }

    let current = 0;
    for (let i = 0; i < 1001; i++) {
        current += diff[i];
        if (current > capacity) return false;
    }

    return true;
};