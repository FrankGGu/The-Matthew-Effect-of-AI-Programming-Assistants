var countServers = function(n, logs, x) {
    const counts = new Array(x.length).fill(0);

    for (let i = 0; i < x.length; i++) {
        let count = 0;
        for (let j = 0; j < logs.length; j++) {
            if (logs[j][0] <= x[i] && x[i] <= logs[j][1]) {
                count++;
            }
        }
        counts[i] = n - count;
    }

    return counts;
};