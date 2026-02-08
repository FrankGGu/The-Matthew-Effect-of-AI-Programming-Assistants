var countZeroRequestServers = function(n, requests, duration, queries) {
    const indexedQueries = queries.map((q, index) => [q, index]);

    requests.sort((a, b) => a[0] - b[0]);
    indexedQueries.sort((a, b) => a[0] - b[0]);

    const ans = new Array(queries.length);
    const serverCounts = new Map();

    let left = 0;
    let right = 0;

    for (let i = 0; i < indexedQueries.length; i++) {
        const currentQueryTime = indexedQueries[i][0];
        const originalIndex = indexedQueries[i][1];
        const windowEnd = currentQueryTime + duration;

        while (right < requests.length && requests[right][0] <= windowEnd) {
            const serverId = requests[right][1];
            serverCounts.set(serverId, (serverCounts.get(serverId) || 0) + 1);
            right++;
        }

        while (left < requests.length && requests[left][0] < currentQueryTime) {
            const serverId = requests[left][1];
            serverCounts.set(serverId, serverCounts.get(serverId) - 1);
            if (serverCounts.get(serverId) === 0) {
                serverCounts.delete(serverId);
            }
            left++;
        }

        ans[originalIndex] = n - serverCounts.size;
    }

    return ans;
};