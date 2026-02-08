var countPairs = function(n, edges, queries) {
    const degree = new Array(n + 1).fill(0);
    const sameEdges = new Map();

    for (const [u, v] of edges) {
        degree[u]++;
        degree[v]++;
        const key = Math.min(u, v) + ',' + Math.max(u, v);
        sameEdges.set(key, (sameEdges.get(key) || 0) + 1);
    }

    const sortedDegree = [...degree].slice(1).sort((a, b) => a - b);
    const result = [];

    for (const query of queries) {
        let count = 0;
        let left = 0;
        let right = n - 1;

        while (left < right) {
            if (sortedDegree[left] + sortedDegree[right] > query) {
                count += right - left;
                right--;
            } else {
                left++;
            }
        }

        for (const [key, val] of sameEdges) {
            const [u, v] = key.split(',').map(Number);
            if (degree[u] + degree[v] > query && degree[u] + degree[v] - val <= query) {
                count--;
            }
        }

        result.push(count);
    }

    return result;
};