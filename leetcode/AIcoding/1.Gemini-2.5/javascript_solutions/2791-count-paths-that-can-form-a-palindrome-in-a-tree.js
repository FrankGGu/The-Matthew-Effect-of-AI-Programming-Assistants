var countPalindromePaths = function(n, edges, s) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let ans = 0;
    const maskCounts = new Map(); // Stores frequencies of path_mask(x) ^ (1 << char_at_x)

    // Initialize with a virtual parent of the root.
    // The mask for this virtual node's path_mask(x) ^ (1 << char_at_x) is 0.
    // This allows paths starting from the root to be counted correctly.
    maskCounts.set(0, 1);

    function dfs(u, p, maskFromRootToParent) {
        // char_val_u is the bitmask for the character at node u
        const char_val_u = 1 << (s.charCodeAt(u) - 'a'.charCodeAt(0));

        // maskFromRootToU is path_mask(u) (XOR sum of characters from root to u, inclusive)
        const maskFromRootToU = maskFromRootToParent ^ char_val_u;

        // Count paths `v -> u` where `v` is an ancestor of `u`.
        // The XOR sum of characters on path `v -> u` (inclusive of v and u) is:
        // path_mask(u) ^ path_mask(v) ^ (1 << char_at_v)
        // We need this XOR sum to be a palindrome mask (0 or 1 << k).
        // This implies: path_mask(v) ^ (1 << char_at_v) must be `maskFromRootToU` or `maskFromRootToU ^ (1 << k)`.
        // The `maskCounts` map stores `path_mask(x) ^ (1 << char_at_x)` for ancestors `x`.

        // Case 1: path_mask(v) ^ (1 << char_at_v) === maskFromRootToU
        // This corresponds to a path `v -> u` whose XOR sum is 0 (all character counts are even).
        ans += maskCounts.get(maskFromRootToU) || 0;

        // Case 2: path_mask(v) ^ (1 << char_at_v) === maskFromRootToU ^ (1 << k)
        // This corresponds to a path `v -> u` whose XOR sum is (1 << k) (exactly one character count is odd).
        for (let k = 0; k < 26; k++) {
            ans += maskCounts.get(maskFromRootToU ^ (1 << k)) || 0;
        }

        // Add `path_mask(u) ^ (1 << char_at_u)` to `maskCounts` for its descendants.
        // This value is `maskFromRootToU ^ char_val_u`.
        const maskToStore = maskFromRootToU ^ char_val_u;
        maskCounts.set(maskToStore, (maskCounts.get(maskToStore) || 0) + 1);

        for (const v of adj[u]) {
            if (v === p) continue;
            dfs(v, u, maskFromRootToU);
        }

        // Backtrack: remove the current node's mask from maskCounts.
        // This ensures that `maskToStore` is only considered for its descendants.
        maskCounts.set(maskToStore, maskCounts.get(maskToStore) - 1);
        if (maskCounts.get(maskToStore) === 0) {
            maskCounts.delete(maskToStore);
        }
    }

    dfs(0, -1, 0);

    // The DFS counts paths `v -> u` where `v` is an ancestor of `u` (or `v=u`).
    // The problem states `u != v`.
    // Each node `u` forms a path `u -> u`. The string `s[u]` is a palindrome.
    // This path is counted by the logic (e.g., `path_mask(u) ^ path_mask(u) ^ (1 << char_at_u)` is `(1 << char_at_u)`, which is a palindrome).
    // These `N` paths must be excluded.
    return ans - n;
};