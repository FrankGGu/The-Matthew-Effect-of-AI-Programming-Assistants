var maximumDetonation = function(bombs) {
    const n = bombs.length;
    const adj = Array(n).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            const [x1, y1, r1] = bombs[i];
            const [x2, y2] = bombs[j];
            const distSq = (x1 - x2) ** 2 + (y1 - y2) ** 2;
            if (distSq <= r1 ** 2) {
                adj[i].push(j);
            }
        }
    }

    let maxDetonated = 0;

    for (let i = 0; i < n; i++) {
        let visited = new Array(n).fill(false);
        let count = 0;
        let queue = [i];
        visited[i] = true;
        count++;

        while (queue.length > 0) {
            const curr = queue.shift();
            for (const neighbor of adj[curr]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.push(neighbor);
                    count++;
                }
            }
        }
        maxDetonated = Math.max(maxDetonated, count);
    }

    return maxDetonated;
};