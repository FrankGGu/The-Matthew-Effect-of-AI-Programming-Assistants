var maximumDetonation = function(bombs) {
    const n = bombs.length;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < n; i++) {
        const [x1, y1, r1] = bombs[i];
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            const [x2, y2] = bombs[j];
            const distance = Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
            if (distance <= r1) {
                graph[i].push(j);
            }
        }
    }

    let maxDetonations = 0;

    for (let i = 0; i < n; i++) {
        const visited = new Set();
        const queue = [i];
        visited.add(i);
        let count = 0;

        while (queue.length > 0) {
            const current = queue.shift();
            count++;
            for (const neighbor of graph[current]) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push(neighbor);
                }
            }
        }

        maxDetonations = Math.max(maxDetonations, count);
    }

    return maxDetonations;
};