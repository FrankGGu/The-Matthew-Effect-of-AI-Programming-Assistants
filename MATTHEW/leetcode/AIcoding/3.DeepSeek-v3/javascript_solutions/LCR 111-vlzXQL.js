var calcEquation = function(equations, values, queries) {
    const graph = {};

    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const val = values[i];

        if (!graph[a]) graph[a] = {};
        if (!graph[b]) graph[b] = {};

        graph[a][b] = val;
        graph[b][a] = 1 / val;
    }

    const result = [];

    for (const [start, end] of queries) {
        if (!graph[start] || !graph[end]) {
            result.push(-1.0);
            continue;
        }

        const visited = new Set();
        const queue = [[start, 1.0]];
        let found = false;

        while (queue.length > 0 && !found) {
            const [node, currentVal] = queue.shift();

            if (node === end) {
                result.push(currentVal);
                found = true;
                break;
            }

            visited.add(node);

            for (const neighbor in graph[node]) {
                if (!visited.has(neighbor)) {
                    queue.push([neighbor, currentVal * graph[node][neighbor]]);
                }
            }
        }

        if (!found) {
            result.push(-1.0);
        }
    }

    return result;
};