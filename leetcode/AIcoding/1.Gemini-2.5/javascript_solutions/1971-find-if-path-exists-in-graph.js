var validPath = function(n, edges, source, destination) {
    if (source === destination) {
        return true;
    }

    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const queue = [source];
    visited[source] = true;

    while (queue.length > 0) {
        const node = queue.shift();

        if (node === destination) {
            return true;
        }

        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push(neighbor);
            }
        }
    }

    return false;
};