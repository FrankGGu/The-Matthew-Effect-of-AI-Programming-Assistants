var countRootNodes = function(edges) {
    const indegree = new Map();
    for (const [u, v] of edges) {
        indegree.set(v, (indegree.get(v) || 0) + 1);
        if (!indegree.has(u)) {
            indegree.set(u, 0);
        }
    }
    let count = 0;
    for (const [node, degree] of indegree) {
        if (degree === 0) {
            count++;
        }
    }
    return count;
};