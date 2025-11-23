var transportationHub = function(path) {
    const inDegree = new Map();
    const outDegree = new Map();
    const nodes = new Set();

    for (const [u, v] of path) {
        nodes.add(u);
        nodes.add(v);
        outDegree.set(u, (outDegree.get(u) || 0) + 1);
        inDegree.set(v, (inDegree.get(v) || 0) + 1);
    }

    const totalNodes = nodes.size;
    for (const node of nodes) {
        if (inDegree.get(node) === totalNodes - 1 && outDegree.get(node) === 0) {
            return node;
        }
    }

    return -1;
};