var countVisitedNodes = function(edges) {
    const n = edges.length;
    const visited = new Array(n).fill(-1);
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (visited[i] === -1) {
            let path = [];
            let current = i;
            while (current !== -1 && visited[current] === -1) {
                visited[current] = i;
                path.push(current);
                current = edges[current];
            }
            if (current !== -1 && visited[current] === i) {
                const cycleStart = path.indexOf(current);
                const cycleLength = path.length - cycleStart;
                for (let j = cycleStart; j < path.length; j++) {
                    result[path[j]] = cycleLength;
                }
                for (let j = 0; j < cycleStart; j++) {
                    result[path[j]] = cycleStart - j + cycleLength;
                }
            } else {
                for (let j = 0; j < path.length; j++) {
                    let next = edges[path[j]];
                    result[path[j]] = 1 + (next === -1 ? 0 : result[next]);
                }
            }
        }
    }
    return result;
};