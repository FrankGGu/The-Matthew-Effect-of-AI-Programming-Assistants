var getAncestors = function(n, edges) {
    const graph = new Array(n).fill().map(() => []);
    const inDegree = new Array(n).fill(0);
    const ancestors = new Array(n).fill().map(() => new Set());

    for (const [u, v] of edges) {
        graph[u].push(v);
        inDegree[v]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of graph[u]) {
            ancestors[v].add(u);
            for (const ancestor of ancestors[u]) {
                ancestors[v].add(ancestor);
            }
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return ancestors.map(set => Array.from(set).sort((a, b) => a - b));
};