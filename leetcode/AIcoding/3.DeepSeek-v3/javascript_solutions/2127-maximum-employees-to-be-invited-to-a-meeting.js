var maximumInvitations = function(favorite) {
    const n = favorite.length;
    const visited = new Array(n).fill(false);
    let maxCycle = 0;
    let sumPairs = 0;

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const path = [];
            let current = i;
            while (true) {
                if (visited[current]) {
                    const index = path.indexOf(current);
                    if (index !== -1) {
                        const cycleLength = path.length - index;
                        maxCycle = Math.max(maxCycle, cycleLength);
                    }
                    break;
                }
                visited[current] = true;
                path.push(current);
                current = favorite[current];
            }
        }
    }

    const reverseGraph = new Array(n).fill().map(() => []);
    for (let i = 0; i < n; i++) {
        reverseGraph[favorite[i]].push(i);
    }

    for (let i = 0; i < n; i++) {
        if (favorite[favorite[i]] === i && i < favorite[i]) {
            const a = i;
            const b = favorite[i];
            const maxA = maxDepth(a, b, reverseGraph);
            const maxB = maxDepth(b, a, reverseGraph);
            sumPairs += maxA + maxB;
        }
    }

    return Math.max(maxCycle, sumPairs);
};

function maxDepth(node, exclude, graph) {
    let max = 0;
    const stack = [[node, 1]];
    while (stack.length) {
        const [current, depth] = stack.pop();
        max = Math.max(max, depth);
        for (const neighbor of graph[current]) {
            if (neighbor !== exclude) {
                stack.push([neighbor, depth + 1]);
            }
        }
    }
    return max;
}