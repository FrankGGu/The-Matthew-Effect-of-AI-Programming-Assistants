var countServers = function(n, logs, x, queries) {
    logs.sort((a, b) => a[1] - b[1]);
    const queriesWithIndices = queries.map((q, idx) => [q, idx]).sort((a, b) => a[0] - b[0]);
    const serverCounts = new Map();
    let left = 0, right = 0;
    const result = new Array(queries.length).fill(0);

    for (const [query, idx] of queriesWithIndices) {
        const start = query - x;
        const end = query;

        while (right < logs.length && logs[right][1] <= end) {
            const server = logs[right][0];
            serverCounts.set(server, (serverCounts.get(server) || 0) + 1);
            right++;
        }

        while (left < logs.length && logs[left][1] < start) {
            const server = logs[left][0];
            const count = serverCounts.get(server);
            if (count === 1) {
                serverCounts.delete(server);
            } else {
                serverCounts.set(server, count - 1);
            }
            left++;
        }

        result[idx] = n - serverCounts.size;
    }

    return result;
};