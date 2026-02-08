var validArrangement = function(pairs) {
    const graph = new Map();
    const indegree = new Map();
    const outdegree = new Map();

    for (const [u, v] of pairs) {
        if (!graph.has(u)) graph.set(u, []);
        graph.get(u).push(v);

        indegree.set(v, (indegree.get(v) || 0) + 1);
        outdegree.set(u, (outdegree.get(u) || 0) + 1);
    }

    let start = pairs[0][0];
    let foundStart = false;
    for (const u of graph.keys()) {
        const inDegreeU = indegree.get(u) || 0;
        const outDegreeU = outdegree.get(u) || 0;

        if (outDegreeU - inDegreeU === 1) {
            start = u;
            foundStart = true;
            break;
        }
    }

    if (!foundStart) {
        start = pairs[0][0];
    }

    const result = [];
    const dfs = (u) => {
        while (graph.has(u) && graph.get(u).length > 0) {
            const v = graph.get(u).pop();
            dfs(v);
            result.push([u, v]);
        }
    };

    dfs(start);
    return result.reverse();
};