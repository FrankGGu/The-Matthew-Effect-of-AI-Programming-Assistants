var findShortestCycle = function(graph) {
    const n = graph.length;
    let shortest = Infinity;

    const bfs = (start) => {
        const queue = [[start, -1, 0]];
        const visited = new Array(n).fill(false);
        visited[start] = true;

        while (queue.length) {
            const [node, parent, depth] = queue.shift();

            for (const neighbor of graph[node]) {
                if (neighbor === parent) continue;
                if (visited[neighbor]) {
                    shortest = Math.min(shortest, depth + 1);
                } else {
                    visited[neighbor] = true;
                    queue.push([neighbor, node, depth + 1]);
                }
            }
        }
    };

    for (let i = 0; i < n; i++) {
        bfs(i);
    }

    return shortest === Infinity ? -1 : shortest;
};