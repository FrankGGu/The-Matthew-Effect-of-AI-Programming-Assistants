var longestCycle = function(edges) {
    let maxCycle = -1;
    const visited = new Array(edges.length).fill(false);

    for (let i = 0; i < edges.length; i++) {
        if (!visited[i]) {
            const distance = new Map();
            distance.set(i, 1);
            let current = i;
            while (true) {
                visited[current] = true;
                const next = edges[current];
                if (next === -1) break;
                if (distance.has(next)) {
                    maxCycle = Math.max(maxCycle, distance.get(current) - distance.get(next) + 1);
                    break;
                }
                if (visited[next]) break;
                distance.set(next, distance.get(current) + 1);
                current = next;
            }
        }
    }
    return maxCycle;
};