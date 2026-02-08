var isPossible = function(n, edges) {
    const adj = Array(n + 1).fill(0).map(() => new Set());
    const degrees = Array(n + 1).fill(0);

    for (const [u, v] of edges) {
        adj[u].add(v);
        adj[v].add(u);
        degrees[u]++;
        degrees[v]++;
    }

    const oddDegreeNodes = [];
    for (let i = 1; i <= n; i++) {
        if (degrees[i] % 2 !== 0) {
            oddDegreeNodes.push(i);
        }
    }

    const numOdd = oddDegreeNodes.length;

    if (numOdd === 0) {
        return true;
    }

    if (numOdd === 2) {
        const [u, v] = oddDegreeNodes;
        // Option 1: Add one edge (u, v)
        // This makes both u and v even.
        if (!adj[u].has(v)) {
            return true;
        }
        // Option 2: Add two edges (u, x) and (v, x) for some node x
        // This makes u and v even, and x's degree changes by 2 (maintains parity).
        // Since x was initially even, it remains even.
        for (let x = 1; x <= n; x++) {
            // Ensure the new edges don't already exist
            if (!adj[u].has(x) && !adj[v].has(x)) {
                return true;
            }
        }
        return false;
    }

    if (numOdd === 4) {
        const [a, b, c, d] = oddDegreeNodes;
        // We need to add exactly two edges to fix 4 odd degrees.
        // There are three ways to pair them up:
        // 1. Add (a,b) and (c,d)
        if (!adj[a].has(b) && !adj[c].has(d)) {
            return true;
        }
        // 2. Add (a,c) and (b,d)
        if (!adj[a].has(c) && !adj[b].has(d)) {
            return true;
        }
        // 3. Add (a,d) and (b,c)
        if (!adj[a].has(d) && !adj[b].has(c)) {
            return true;
        }
        return false;
    }

    // If numOdd is 1, 3, or >= 6, it's impossible to make all degrees even
    // by adding at most two edges.
    // (Number of odd degree nodes must always be even in a valid graph, so 1, 3, 5 are not expected)
    // If numOdd >= 6, we need at least 3 edges to fix.
    return false;
};