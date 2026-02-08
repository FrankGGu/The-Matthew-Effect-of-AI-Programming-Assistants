var isBipartite = function(n, edges) {
    const graph = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const colors = Array(n).fill(0); // 0: uncolored, 1: color 1, -1: color -1

    for (let i = 0; i < n; i++) {
        if (colors[i] === 0) {
            const queue = [i];
            colors[i] = 1;

            while (queue.length > 0) {
                const u = queue.shift();

                for (const v of graph[u]) {
                    if (colors[v] === 0) {
                        colors[v] = -colors[u];
                        queue.push(v);
                    } else if (colors[v] === colors[u]) {
                        return false;
                    }
                }
            }
        }
    }

    return true;
};