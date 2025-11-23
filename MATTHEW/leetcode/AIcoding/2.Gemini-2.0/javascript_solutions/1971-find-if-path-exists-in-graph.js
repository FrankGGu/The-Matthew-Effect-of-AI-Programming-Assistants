var validPath = function(n, edges, start, end) {
    const adjList = new Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adjList[u].push(v);
        adjList[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const queue = [start];
    visited[start] = true;

    while (queue.length > 0) {
        const u = queue.shift();
        if (u === end) {
            return true;
        }

        for (const v of adjList[u]) {
            if (!visited[v]) {
                visited[v] = true;
                queue.push(v);
            }
        }
    }

    return false;
};