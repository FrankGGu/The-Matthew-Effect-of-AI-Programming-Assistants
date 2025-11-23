var calcEquation = function(equations, values, queries) {
    const graph = {};

    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const value = values[i];

        if (!graph[a]) graph[a] = {};
        if (!graph[b]) graph[b] = {};

        graph[a][b] = value;
        graph[b][a] = 1 / value;
    }

    const result = [];

    for (const [start, end] of queries) {
        if (!graph[start] || !graph[end]) {
            result.push(-1);
            continue;
        }

        const visited = new Set();
        const queue = [[start, 1]];
        let found = false;

        while (queue.length > 0 && !found) {
            const [node, currentValue] = queue.shift();

            if (node === end) {
                result.push(currentValue);
                found = true;
                break;
            }

            visited.add(node);

            for (const neighbor in graph[node]) {
                if (!visited.has(neighbor)) {
                    queue.push([neighbor, currentValue * graph[node][neighbor]]);
                }
            }
        }

        if (!found) {
            result.push(-1);
        }
    }

    return result;
};