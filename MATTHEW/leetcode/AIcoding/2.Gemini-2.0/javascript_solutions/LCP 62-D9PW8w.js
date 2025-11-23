var transportationHub = function(paths) {
    const n = paths.length;
    if (n === 0) return 1;

    const outDegree = new Map();
    const inDegree = new Map();

    for (const [u, v] of paths) {
        outDegree.set(u, (outDegree.get(u) || 0) + 1);
        inDegree.set(v, (inDegree.get(v) || 0) + 1);
    }

    const nodes = new Set();
    for (const [u, v] of paths) {
        nodes.add(u);
        nodes.add(v);
    }

    const nodeCount = nodes.size;

    for (const node of nodes) {
        if ((inDegree.get(node) || 0) === nodeCount - 1 && (outDegree.get(node) || 0) === 0) {
            return node;
        }
    }

    return -1;
};