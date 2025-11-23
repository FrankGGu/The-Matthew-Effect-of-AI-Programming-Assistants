function countPairs(n, edges, queries) {
    const tree = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        tree[u].push([v, w]);
        tree[v].push([u, w]);
    }

    const getDistances = (start) => {
        const dist = new Array(n).fill(0);
        const visited = new Array(n).fill(false);
        const queue = [[start, 0]];
        visited[start] = true;

        while (queue.length > 0) {
            const [node, d] = queue.shift();
            dist[node] = d;
            for (const [neighbor, weight] of tree[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.push([neighbor, d + weight]);
                }
            }
        }

        return dist;
    };

    const result = [];
    for (const q of queries) {
        let count = 0;
        const distances = getDistances(q);
        for (let i = 0; i < n; i++) {
            for (let j = i + 1; j < n; j++) {
                if (distances[i] + distances[j] > q) {
                    count++;
                }
            }
        }
        result.push(count);
    }

    return result;
}