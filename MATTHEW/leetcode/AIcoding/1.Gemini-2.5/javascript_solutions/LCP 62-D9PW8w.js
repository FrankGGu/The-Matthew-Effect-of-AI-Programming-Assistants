var trafficHub = function(n, roads) {
    if (n === 1) {
        return 0;
    }

    const inDegree = new Array(n).fill(0);
    const outDegree = new Array(n).fill(0);

    for (const [from, to] of roads) {
        outDegree[from]++;
        inDegree[to]++;
    }

    for (let i = 0; i < n; i++) {
        if (inDegree[i] === n - 1 && outDegree[i] === 0) {
            return i;
        }
    }

    return -1;
};