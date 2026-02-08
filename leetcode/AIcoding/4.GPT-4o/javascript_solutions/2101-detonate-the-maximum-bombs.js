var maximumDetonations = function(bombs) {
    const n = bombs.length;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                const [x1, y1, r1] = bombs[i];
                const [x2, y2] = bombs[j];
                const distance = (x1 - x2) ** 2 + (y1 - y2) ** 2;
                if (distance <= r1 ** 2) {
                    graph[i].push(j);
                }
            }
        }
    }

    const dfs = (node, visited) => {
        visited[node] = true;
        let count = 1;
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                count += dfs(neighbor, visited);
            }
        }
        return count;
    };

    let maxDetonated = 0;

    for (let i = 0; i < n; i++) {
        const visited = Array(n).fill(false);
        maxDetonated = Math.max(maxDetonated, dfs(i, visited));
    }

    return maxDetonated;
};