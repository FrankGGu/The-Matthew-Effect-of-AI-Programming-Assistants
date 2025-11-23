var minReorder = function(n, connections) {
    const graph = Array.from({ length: n }, () => []);
    const reverseGraph = Array.from({ length: n }, () => []);

    for (const [u, v] of connections) {
        graph[u].push(v);
        reverseGraph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    let count = 0;
    const queue = [0];
    visited[0] = true;

    while (queue.length > 0) {
        const node = queue.shift();

        for (const neighbor of reverseGraph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push(neighbor);
            }
        }

        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push(neighbor);
                count++;
            }
        }
    }

    return count;
};