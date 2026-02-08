var findSmallestSetOfVertices = function(n, edges) {
    const inDegree = new Array(n).fill(0);
    for (const [u, v] of edges) {
        inDegree[v]++;
    }
    const result = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            result.push(i);
        }
    }
    return result;
};