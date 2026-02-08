function validArrangement(pairs) {
    const graph = new Map();
    const inDegree = new Map();
    const outDegree = new Map();

    for (const [u, v] of pairs) {
        if (!graph.has(u)) {
            graph.set(u, []);
        }
        graph.get(u).push(v);

        outDegree.set(u, (outDegree.get(u) || 0) + 1);
        inDegree.set(v, (inDegree.get(v) || 0) + 1);
    }

    let start = pairs[0][0];
    for (const [u] of graph) {
        if ((outDegree.get(u) || 0) - (inDegree.get(u) || 0) === 1) {
            start = u;
            break;
        }
    }

    const path = [];
    const stack = [start];
    while (stack.length > 0) {
        let u = stack[stack.length - 1];
        if (graph.has(u) && graph.get(u).length > 0) {
            const v = graph.get(u).pop();
            stack.push(v);
        } else {
            path.push(stack.pop());
        }
    }
    path.reverse();

    const result = [];
    for (let i = 0; i < path.length - 1; i++) {
        result.push([path[i], path[i + 1]]);
    }
    return result;
}