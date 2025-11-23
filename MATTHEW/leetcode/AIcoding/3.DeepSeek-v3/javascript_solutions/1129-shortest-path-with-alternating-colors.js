var shortestAlternatingPaths = function(n, redEdges, blueEdges) {
    const redGraph = new Array(n).fill().map(() => []);
    const blueGraph = new Array(n).fill().map(() => []);

    for (const [u, v] of redEdges) {
        redGraph[u].push(v);
    }

    for (const [u, v] of blueEdges) {
        blueGraph[u].push(v);
    }

    const answer = new Array(n).fill(-1);
    const visited = new Set();
    const queue = [];

    queue.push([0, null, 0]); // [node, prevColor, distance]
    visited.add(`0-null`);
    answer[0] = 0;

    while (queue.length > 0) {
        const [node, prevColor, dist] = queue.shift();

        if (prevColor !== 'red') {
            for (const neighbor of redGraph[node]) {
                const key = `${neighbor}-red`;
                if (!visited.has(key)) {
                    visited.add(key);
                    if (answer[neighbor] === -1) {
                        answer[neighbor] = dist + 1;
                    }
                    queue.push([neighbor, 'red', dist + 1]);
                }
            }
        }

        if (prevColor !== 'blue') {
            for (const neighbor of blueGraph[node]) {
                const key = `${neighbor}-blue`;
                if (!visited.has(key)) {
                    visited.add(key);
                    if (answer[neighbor] === -1) {
                        answer[neighbor] = dist + 1;
                    }
                    queue.push([neighbor, 'blue', dist + 1]);
                }
            }
        }
    }

    return answer;
};