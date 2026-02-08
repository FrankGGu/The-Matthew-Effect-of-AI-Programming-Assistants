var calcEquation = function(equations, values, queries) {
    const parent = new Map(); // Stores parent of each variable
    const weights = new Map(); // Stores the ratio: variable / parent (i.e., variable / parent[variable])

    // Helper function to initialize a variable if not seen before
    function init(x) {
        if (!parent.has(x)) {
            parent.set(x, x); // Each variable is its own parent initially
            weights.set(x, 1.0); // Ratio x/x is 1.0
        }
    }

    // Find function with path compression and weight updates
    // Returns [root, x / root]
    function find(x) {
        init(x); // Ensure x is initialized
        if (parent.get(x) === x) {
            return [x, 1.0]; // x is the root, x/x = 1.0
        }

        // Recursively find the root and the ratio from parent[x] to root
        const [root, ratioFromParentToRoot] = find(parent.get(x));

        // Path compression: set parent of x directly to root
        parent.set(x, root);

        // Update weight of x: (x / root) = (x / parent[x]) * (parent[x] / root)
        weights.set(x, weights.get(x) * ratioFromParentToRoot);

        return [root, weights.get(x)];
    }

    // Union function: processes a / b = val
    function union(a, b, val) {
        init(a); // Ensure a is initialized
        init(b); // Ensure b is initialized

        const [rootA, ratioA] = find(a); // ratioA is a / rootA
        const [rootB, ratioB] = find(b); // ratioB is b / rootB

        if (rootA !== rootB) {
            parent.set(rootA, rootB); // Make rootA a child of rootB

            // We need to set weights[rootA], which is rootA / rootB
            // We know:
            // 1. a / rootA = ratioA  => rootA = a / ratioA
            // 2. b / rootB = ratioB  => rootB = b / ratioB
            // 3. a / b     = val
            //
            // Substitute (1) and (2) into rootA / rootB:
            // rootA / rootB = (a / ratioA) / (b / ratioB)
            //               = (a / b) * (ratioB / ratioA)
            // Substitute (3):
            //               = val * (ratioB / ratioA)
            weights.set(rootA, (val * ratioB) / ratioA);
        }
    }

    // Process all equations to build the graph
    for (let i = 0; i < equations.length; i++) {
        const [a, b] = equations[i];
        const val = values[i];
        union(a, b, val);
    }

    const results = [];
    // Process all queries
    for (const [c, d] of queries) {
        // Check if both variables exist in our graph
        if (!parent.has(c) || !parent.has(d)) {
            results.push(-1.0);
            continue;
        }

        const [rootC, ratioC] = find(c); // ratioC is c / rootC
        const [rootD, ratioD] = find(d); // ratioD is d / rootD

        if (rootC !== rootD) {
            results.push(-1.0); // No path between c and d (they are in different components)
        } else {
            // If roots are the same, c and d are connected.
            // c / d = (c / rootC) / (d / rootD) = ratioC / ratioD
            results.push(ratioC / ratioD);
        }
    }

    return results;
};