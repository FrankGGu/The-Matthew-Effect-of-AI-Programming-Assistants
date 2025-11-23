var validArrangement = function(pairs) {
    const adj = new Map();
    const outDegree = new Map();
    const inDegree = new Map();

    for (const [u, v] of pairs) {
        if (!adj.has(u)) {
            adj.set(u, []);
        }
        adj.get(u).push(v);

        outDegree.set(u, (outDegree.get(u) || 0) + 1);
        inDegree.set(v, (inDegree.get(v) || 0) + 1);
    }

    let startNode = pairs[0][0];

    for (const node of outDegree.keys()) {
        const outD = outDegree.get(node) || 0;
        const inD = inDegree.get(node) || 0;
        if (outD === inD + 1) {
            startNode = node;
            break;
        }
    }

    const path = [];

    const dfs = (u) => {
        while (adj.has(u) && adj.get(u).length > 0) {
            const v = adj.get(u).pop();
            dfs(v);
        }
        path.push(u);
    };

    dfs(startNode);

    path.reverse();

    const result = [];
    for (let i = 0; i < path.length - 1; i++) {
        result.push([path[i], path[i+1]]);
    }

    return result;
};