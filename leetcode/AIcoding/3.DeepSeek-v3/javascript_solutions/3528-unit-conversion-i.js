var calcEquation = function(units, queries) {
    const graph = {};

    for (const [from, to, value] of units) {
        if (!graph[from]) graph[from] = {};
        if (!graph[to]) graph[to] = {};
        graph[from][to] = parseFloat(value);
        graph[to][from] = 1 / parseFloat(value);
    }

    const result = [];

    for (const [from, to] of queries) {
        if (!graph[from] || !graph[to]) {
            result.push(-1);
            continue;
        }

        const visited = new Set();
        const queue = [[from, 1]];
        let found = false;

        while (queue.length > 0 && !found) {
            const [current, product] = queue.shift();
            if (current === to) {
                result.push(product);
                found = true;
                break;
            }
            visited.add(current);
            for (const neighbor in graph[current]) {
                if (!visited.has(neighbor)) {
                    queue.push([neighbor, product * graph[current][neighbor]]);
                }
            }
        }

        if (!found) {
            result.push(-1);
        }
    }

    return result;
};