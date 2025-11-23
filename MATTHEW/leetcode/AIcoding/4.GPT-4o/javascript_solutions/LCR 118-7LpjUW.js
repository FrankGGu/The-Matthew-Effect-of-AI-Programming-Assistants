var findRedundantDirectedConnection = function(edges) {
    let parent = new Array(edges.length + 1).fill(0).map((_, i) => i);
    let indegree = new Array(edges.length + 1).fill(0);
    let edgeToRemove = null;

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
            return true;
        }
        return false;
    };

    for (const [u, v] of edges) {
        indegree[v]++;
        if (indegree[v] > 1) {
            edgeToRemove = [u, v];
            continue;
        }
        if (!union(u, v)) {
            edgeToRemove = [u, v];
        }
    }

    return edgeToRemove;
};