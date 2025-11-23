var minEdgeReversals = function(n, edges) {
    const adj = Array.from({ length: n }, () => []);
    const reverseAdj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        reverseAdj[v].push(u);
    }

    const queue = [];
    const visited = new Array(n).fill(false);
    let res = 0;

    queue.push(0);
    visited[0] = true;

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of adj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                queue.push(v);
            }
        }
        for (const v of reverseAdj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                res++;
                queue.push(v);
            }
        }
    }

    return res;
};