var maxMinimumCity = function(A, edges) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const bfs = (start, minPower) => {
        const queue = [start];
        const visited = new Set([start]);
        while (queue.length) {
            const node = queue.shift();
            for (const neighbor of graph.get(node) || []) {
                if (!visited.has(neighbor) && A[neighbor] >= minPower) {
                    visited.add(neighbor);
                    queue.push(neighbor);
                }
            }
        }
        return visited.size === A.length;
    };

    let left = 0, right = Math.max(...A);
    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (bfs(0, mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return left;
};