var calcEquation = function(equations, values, queries) {
    const graph = new Map();

    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const val = values[i];

        if (!graph.has(a)) {
            graph.set(a, new Map());
        }
        if (!graph.has(b)) {
            graph.set(b, new Map());
        }

        graph.get(a).set(b, val);
        graph.get(b).set(a, 1 / val);
    }

    const results = [];

    const dfs = (currentNode, targetNode, currentProduct, visited) => {
        visited.add(currentNode);

        const neighbors = graph.get(currentNode);
        if (neighbors) {
            for (const [neighbor, value] of neighbors.entries()) {
                if (neighbor === targetNode) {
                    return currentProduct * value;
                }
                if (!visited.has(neighbor)) {
                    const result = dfs(neighbor, targetNode, currentProduct * value, visited);
                    if (result !== -1.0) {
                        return result;
                    }
                }
            }
        }
        return -1.0;
    };

    for (const [startNode, endNode] of queries) {
        if (!graph.has(startNode) || !graph.has(endNode)) {
            results.push(-1.0);
        } else if (startNode === endNode) {
            results.push(1.0);
        } else {
            const visited = new Set();
            const result = dfs(startNode, endNode, 1.0, visited);
            results.push(result);
        }
    }

    return results;
};