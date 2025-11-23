var calcEquation = function(equations, values, queries) {
    const graph = new Map();

    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const value = values[i];

        if (!graph.has(a)) {
            graph.set(a, []);
        }
        if (!graph.has(b)) {
            graph.set(b, []);
        }

        graph.get(a).push({ node: b, weight: value });
        graph.get(b).push({ node: a, weight: 1 / value });
    }

    const results = [];

    for (const [start, end] of queries) {
        if (!graph.has(start) || !graph.has(end)) {
            results.push(-1.0);
            continue;
        }

        if (start === end) {
            results.push(1.0);
            continue;
        }

        const visited = new Set();
        let result = -1.0;

        const dfs = (node, target, product) => {
            visited.add(node);

            if (node === target) {
                result = product;
                return;
            }

            for (const neighbor of graph.get(node)) {
                if (!visited.has(neighbor.node)) {
                    dfs(neighbor.node, target, product * neighbor.weight);
                }
            }
        };

        dfs(start, end, 1.0);
        results.push(result);
    }

    return results;
};