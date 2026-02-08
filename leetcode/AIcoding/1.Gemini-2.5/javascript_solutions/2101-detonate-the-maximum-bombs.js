var maximumDetonation = function(bombs) {
    const n = bombs.length;
    if (n === 0) {
        return 0;
    }

    const adj = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;

            const x1 = bombs[i][0];
            const y1 = bombs[i][1];
            const r1 = bombs[i][2];

            const x2 = bombs[j][0];
            const y2 = bombs[j][1];

            const dx = x1 - x2;
            const dy = y1 - y2;

            // Check if bomb i can detonate bomb j
            // Distance squared between centers <= radius of bomb i squared
            if (dx * dx + dy * dy <= r1 * r1) {
                adj[i].push(j);
            }
        }
    }

    let maxDetonated = 0;

    const dfs = (node, visited) => {
        visited.add(node);
        let count = 1;

        for (const neighbor of adj[node]) {
            if (!visited.has(neighbor)) {
                count += dfs(neighbor, visited);
            }
        }
        return count;
    };

    for (let i = 0; i < n; i++) {
        const visited = new Set();
        const currentDetonated = dfs(i, visited);
        maxDetonated = Math.max(maxDetonated, currentDetonated);
    }

    return maxDetonated;
};