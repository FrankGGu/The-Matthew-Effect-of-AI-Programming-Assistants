var loudAndRich = function(richer, quiet) {
    const graph = new Map();
    const indegree = new Array(quiet.length).fill(0);
    for (const [a, b] of richer) {
        if (!graph.has(b)) graph.set(b, []);
        graph.get(b).push(a);
        indegree[a]++;
    }

    const result = new Array(quiet.length).fill(Infinity);
    const queue = [];

    for (let i = 0; i < quiet.length; i++) {
        if (indegree[i] === 0) {
            result[i] = quiet[i];
            queue.push(i);
        }
    }

    while (queue.length) {
        const node = queue.shift();
        for (const neighbor of (graph.get(node) || [])) {
            if (result[neighbor] > result[node]) {
                result[neighbor] = result[node];
                queue.push(neighbor);
            }
        }
    }

    return result;
};