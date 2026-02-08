var possibleBipartition = function(n, dislikes) {
    const adj = new Array(n + 1).fill(0).map(() => []);
    for (const [u, v] of dislikes) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const colors = new Array(n + 1).fill(0); // 0: uncolored, 1: color A, 2: color B

    for (let i = 1; i <= n; i++) {
        if (colors[i] === 0) {
            const queue = [i];
            colors[i] = 1; // Start with color A

            let head = 0;
            while(head < queue.length) {
                const u = queue[head++];
                const currentColor = colors[u];
                const oppositeColor = currentColor === 1 ? 2 : 1;

                for (const v of adj[u]) {
                    if (colors[v] === 0) {
                        colors[v] = oppositeColor;
                        queue.push(v);
                    } else if (colors[v] === currentColor) {
                        return false; // Conflict: adjacent nodes have the same color
                    }
                }
            }
        }
    }

    return true;
};