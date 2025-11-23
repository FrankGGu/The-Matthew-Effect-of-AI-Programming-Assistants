var findSmallestSetOfVertices = function(n, edges) {
    const inDegree = new Array(n).fill(0);
    for (const [_, to] of edges) {
        inDegree[to]++;
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            result.push(i);
        }
    }

    return result;
};