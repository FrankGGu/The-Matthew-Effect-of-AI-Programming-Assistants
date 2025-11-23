var eliminateMaximum = function(dist, speed) {
    const n = dist.length;
    const times = dist.map((d, i) => Math.ceil(d / speed[i])).sort((a, b) => a - b);
    for (let i = 0; i < n; i++) {
        if (times[i] <= i) return i;
    }
    return n;
};