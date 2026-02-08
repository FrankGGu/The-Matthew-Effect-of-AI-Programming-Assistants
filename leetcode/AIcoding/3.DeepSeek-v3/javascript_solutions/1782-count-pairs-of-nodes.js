var countPairs = function(n, edges, queries) {
    const degree = new Array(n + 1).fill(0);
    const edgeCount = new Map();

    for (const [u, v] of edges) {
        degree[u]++;
        degree[v]++;
        const key = u < v ? `${u},${v}` : `${v},${u}`;
        edgeCount.set(key, (edgeCount.get(key) || 0) + 1);
    }

    const sortedDegree = degree.slice(1).sort((a, b) => a - b);
    const res = [];

    for (const q of queries) {
        let count = 0;
        let left = 0, right = n - 1;
        while (left < right) {
            if (sortedDegree[left] + sortedDegree[right] > q) {
                count += right - left;
                right--;
            } else {
                left++;
            }
        }

        for (const [key, cnt] of edgeCount) {
            const [u, v] = key.split(',').map(Number);
            const total = degree[u] + degree[v];
            if (total > q && total - cnt <= q) {
                count--;
            }
        }
        res.push(count);
    }

    return res;
};