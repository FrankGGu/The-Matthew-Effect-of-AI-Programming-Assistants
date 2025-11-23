function numBusesToDestination(areas, source, target) {
    const graph = {};
    for (let i = 0; i < areas.length; i++) {
        for (let j = 0; j < areas[i].length; j++) {
            if (!graph[areas[i][j]]) graph[areas[i][j]] = [];
            for (let k = 0; k < areas[i].length; k++) {
                if (j !== k) {
                    graph[areas[i][j]].push(areas[i][k]);
                }
            }
        }
    }

    const visited = new Set();
    const queue = [[source, 0]];

    while (queue.length > 0) {
        const [current, steps] = queue.shift();
        if (current === target) return steps;
        if (visited.has(current)) continue;
        visited.add(current);
        for (const neighbor of graph[current]) {
            if (!visited.has(neighbor)) {
                queue.push([neighbor, steps + 1]);
            }
        }
    }

    return -1;
}