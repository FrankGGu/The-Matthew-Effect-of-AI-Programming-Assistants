var maximumEdgeValue = function(n, edges, k, values) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // dfs(u, parent) returns a pair [sum_if_u_even, sum_if_u_odd].
    // sum_if_u_even: Maximum sum of values in the subtree rooted at u,
    //                assuming an even number of edges incident to u (from its children) are chosen.
    //                In this case, u's own value contributes `values[u]` to the sum.
    // sum_if_u_odd:  Maximum sum of values in the subtree rooted at u,
    //                assuming an odd number of edges incident to u (from its children) are chosen.
    //                In this case, u's own value contributes `values[u] ^ k` to the sum.
    function dfs(u, parent) {
        // Initialize with u's own value, assuming no children edges are chosen yet (0 edges, which is even).
        // If u's final local parity from children is even, its value is values[u].
        let sum_if_u_even = values[u];
        // If u's final local parity from children is odd, its value is values[u] ^ k.
        let sum_if_u_odd = values[u] ^ k;

        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }

            const [child_even, child_odd] = dfs(v, u);

            // Calculate the new maximum sums for u, considering the current child v.
            // A new sum_if_u_even can be formed in two ways:
            // 1. u was even, child v is even (edge (u,v) not chosen). Total sum: current_sum_if_u_even + child_even.
            // 2. u was odd, child v is odd (edge (u,v) chosen). Total sum: current_sum_if_u_odd + child_odd.
            const next_sum_if_u_even = Math.max(
                sum_if_u_even + child_even,
                sum_if_u_odd + child_odd
            );

            // A new sum_if_u_odd can be formed in two ways:
            // 1. u was even, child v is odd (edge (u,v) chosen). Total sum: current_sum_if_u_even + child_odd.
            // 2. u was odd, child v is even (edge (u,v) not chosen). Total sum: current_sum_if_u_odd + child_even.
            const next_sum_if_u_odd = Math.max(
                sum_if_u_even + child_odd,
                sum_if_u_odd + child_even
            );

            sum_if_u_even = next_sum_if_u_even;
            sum_if_u_odd = next_sum_if_u_odd;
        }

        return [sum_if_u_even, sum_if_u_odd];
    }

    // Start DFS from node 0 (arbitrary root).
    // The root has no parent, so its final parity (even/odd number of chosen edges incident to it)
    // is solely determined by its children. Both even and odd parities are valid final states for the root.
    const [final_even, final_odd] = dfs(0, -1);
    return Math.max(final_even, final_odd);
};