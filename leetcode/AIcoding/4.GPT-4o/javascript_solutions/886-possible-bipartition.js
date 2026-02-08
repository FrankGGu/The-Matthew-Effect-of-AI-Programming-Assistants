var possibleBipartition = function(N, dislikes) {
    const graph = Array.from({length: N + 1}, () => []);
    for (const [u, v] of dislikes) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const color = new Array(N + 1).fill(0);

    const bfs = (start) => {
        const queue = [start];
        color[start] = 1;

        while (queue.length) {
            const node = queue.shift();
            for (const neighbor of graph[node]) {
                if (color[neighbor] === 0) {
                    color[neighbor] = -color[node];
                    queue.push(neighbor);
                } else if (color[neighbor] === color[node]) {
                    return false;
                }
            }
        }
        return true;
    };

    for (let i = 1; i <= N; i++) {
        if (color[i] === 0 && !bfs(i)) {
            return false;
        }
    }
    return true;
};