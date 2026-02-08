var numOfWays = function(pairs) {
    // adj[u] will store the set of nodes v such that u is an ancestor of v (including u itself).
    // Based on the problem statement "for any [x, y] that is not in pairs, x is neither an ancestor of y nor y is an ancestor of x",
    // it implies that `pairs` contains *all* ancestor-descendant relationships.
    // If u is an ancestor of v, then [u,v] must be in `pairs`.
    // If v is an ancestor of u, then [v,u] must be in `pairs`.
    // This means the input `pairs` effectively represents a directed graph where edges go from ancestor to descendant.
    const adj = new Map();
    const allNodes = new Set();

    for (const [u, v] of pairs) {
        allNodes.add(u);
        allNodes.add(v);
        if (!adj.has(u)) adj.set(u, new Set());
        adj.get(u).add(v); // Add v to u's descendant set
    }

    for (const node of allNodes) {
        if (!adj.has(node)) adj.set(node, new Set()); // Ensure all nodes have a set, even if they are leaves
        adj.get(node).add(node); // Each node is an ancestor of itself
    }

    const n = allNodes.size;

    // Handle edge cases for n=0 or n=1
    if (n === 0) return 0;
    if (n === 1) {
        // A single node tree has no pairs. If pairs is empty, 1 way. Otherwise, 0 ways.
        return pairs.length === 0 ? 1 : 0;
    }

    const nodes = Array.from(allNodes);
    // Sort nodes by the size of their descendant sets in descending order.
    // Ancestors will have larger descendant sets than their descendants.
    nodes.sort((a, b) => adj.get(b).size - adj.get(a).size);

    let ans = 1;

    // The first node in the sorted list must be the root.
    // Its descendant set must contain all `n` nodes.
    const root = nodes[0];
    if (adj.get(root).size !== n) {
        return 0; // No node is an ancestor of all others, or the input graph is disconnected/invalid.
    }

    // Iterate through the rest of the nodes to find their parents and validate the tree structure.
    for (let i = 1; i < n; i++) {
        const u = nodes[i];
        const uSet = adj.get(u);

        let parent = -1;
        let minParentSetSize = Infinity;

        // Find the immediate parent for 'u' among already processed nodes (potential ancestors).
        // These nodes are `nodes[0]` to `nodes[i-1]`, which are guaranteed to have descendant sets
        // of size greater than or equal to `uSet.size` due to sorting.
        for (let j = 0; j < i; j++) {
            const p = nodes[j];
            const pSet = adj.get(p);

            // 'p' is a potential parent if 'p' is an ancestor of 'u'.
            // Since `pairs` contains all ancestor-descendant relationships, if `p` is an ancestor of `u`,
            // then `u` must be in `p`'s descendant set (`pSet.has(u)`).
            if (pSet.has(u)) {
                // Additionally, if `p` is an ancestor of `u`, then all descendants of `u` must also be descendants of `p`.
                // This means `uSet` must be a subset of `pSet`. This is a crucial consistency check for the input `pairs`.
                let isSubset = true;
                for (const nodeInU of uSet) {
                    if (!pSet.has(nodeInU)) {
                        isSubset = false;
                        break;
                    }
                }
                if (!isSubset) {
                    return 0; // Inconsistent input: 'p' is an ancestor of 'u', but 'u' has a descendant not in 'p's descendants.
                }

                // 'p' is a valid ancestor. Now, we need to find the *immediate* parent.
                // The immediate parent is the ancestor with the smallest descendant set size that strictly contains `uSet`.
                // If multiple ancestors have the same minimal size, any can be chosen as parent.
                if (pSet.size < minParentSetSize) {
                    minParentSetSize = pSet.size;
                    parent = p;
                }
            }
        }

        if (parent === -1) {
            return 0; // No valid parent found for 'u'. This means 'u' cannot be placed in the tree.
        }

        // If 'u' and its chosen parent have the same size descendant sets, it implies that 'u' and 'parent'
        // are indistinguishable in terms of their ancestor-descendant relationships.
        // This means 'u' could effectively replace 'parent' in the tree structure without violating `pairs`.
        // This scenario indicates that there are multiple ways to reconstruct the tree.
        if (adj.get(parent).size === uSet.size) {
            ans = 2;
        }
    }

    return ans;
};