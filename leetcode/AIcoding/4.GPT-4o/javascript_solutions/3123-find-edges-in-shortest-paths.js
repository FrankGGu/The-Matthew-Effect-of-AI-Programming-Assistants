class Solution {
    findEdges(n, edges, queries) {
        const graph = Array.from({ length: n }, () => []);
        for (const [u, v] of edges) {
            graph[u].push(v);
            graph[v].push(u);
        }

        const bfs = (start) => {
            const distance = Array(n).fill(Infinity);
            const queue = [start];
            distance[start] = 0;

            while (queue.length) {
                const node = queue.shift();
                for (const neighbor of graph[node]) {
                    if (distance[neighbor] === Infinity) {
                        distance[neighbor] = distance[node] + 1;
                        queue.push(neighbor);
                    }
                }
            }
            return distance;
        };

        const results = [];
        for (const query of queries) {
            const [u, v] = query;
            const distFromU = bfs(u);
            const distFromV = bfs(v);
            let count = 0;

            for (let i = 0; i < n; i++) {
                if (distFromU[i] + distFromV[i] === distFromU[v]) {
                    count++;
                }
            }
            results.push(count);
        }
        return results;
    }
}