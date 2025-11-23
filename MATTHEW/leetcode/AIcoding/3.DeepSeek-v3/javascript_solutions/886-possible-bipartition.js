var possibleBipartition = function(N, dislikes) {
    const graph = Array.from({length: N + 1}, () => []);
    for (const [a, b] of dislikes) {
        graph[a].push(b);
        graph[b].push(a);
    }

    const colors = new Array(N + 1).fill(0);

    for (let i = 1; i <= N; i++) {
        if (colors[i] === 0 && !dfs(i, 1)) {
            return false;
        }
    }

    return true;

    function dfs(node, color) {
        if (colors[node] !== 0) {
            return colors[node] === color;
        }
        colors[node] = color;
        for (const neighbor of graph[node]) {
            if (!dfs(neighbor, -color)) {
                return false;
            }
        }
        return true;
    }
};