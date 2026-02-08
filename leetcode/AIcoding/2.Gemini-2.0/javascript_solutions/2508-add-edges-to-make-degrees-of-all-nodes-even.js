var addEdges = function(n, edges) {
    const adj = Array(n + 1).fill(null).map(() => []);
    const degree = Array(n + 1).fill(0);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    const oddNodes = [];
    for (let i = 1; i <= n; i++) {
        if (degree[i] % 2 !== 0) {
            oddNodes.push(i);
        }
    }

    const result = [];
    if (oddNodes.length === 0) {
        return [];
    } else if (oddNodes.length === 2) {
        result.push([oddNodes[0], oddNodes[1]]);
        return result;
    } else if (oddNodes.length === 4) {
        let a = oddNodes[0];
        let b = oddNodes[1];
        let c = oddNodes[2];
        let d = oddNodes[3];

        for (let i = 1; i <= n; i++) {
            if (i !== a && i !== b && i !== c && i !== d) {
                result.push([a, b]);
                result.push([c, d]);
                return result;
            }
        }

        result.push([a, b]);
        result.push([c, d]);
        return result;
    } else {
        const a = oddNodes[0];
        const b = oddNodes[1];
        const c = oddNodes[2];
        const d = oddNodes[3];
        const e = oddNodes[4];
        const f = oddNodes[5];
        result.push([oddNodes[0], oddNodes[1]]);
        result.push([oddNodes[2], oddNodes[3]]);
        result.push([oddNodes[4], oddNodes[5]]);
        return result;
    }

};