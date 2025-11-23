var numberOfCoins = function(n, edges, cost) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const ans = Array(n).fill(0n); // Use BigInt for results

    // Convert costs to BigInt
    const bigCost = cost.map(c => BigInt(c));

    function dfs(u, parent) {
        let currentSubtreeValues = [bigCost[u]];

        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }
            const childExtremes = dfs(v, u); // childExtremes is a sorted array of BigInts
            currentSubtreeValues.push(...childExtremes);
        }

        // Sort all values collected from current node and its subtree
        currentSubtreeValues.sort((a, b) => {
            if (a < b) return -1;
            if (a > b) return 1;
            return 0;
        });

        // Calculate ans[u] based on the sorted values
        const len = currentSubtreeValues.length;
        if (len < 3) {
            ans[u] = 1n; // Use BigInt 1
        } else {
            const v1 = currentSubtreeValues[0];
            const v2 = currentSubtreeValues[1];
            const v_last = currentSubtreeValues[len - 1];
            const v_second_last = currentSubtreeValues[len - 2];
            const v_third_last = currentSubtreeValues[len - 3];

            // Calculate product of three largest values
            const product1 = v_last * v_second_last * v_third_last;
            // Calculate product of two smallest (most negative) and one largest value
            const product2 = v1 * v2 * v_last;

            // Choose the maximum of the two products
            let maxProduct = (product1 > product2 ? product1 : product2);

            // If the maximum product is negative, the result is 0
            if (maxProduct < 0n) {
                maxProduct = 0n;
            }
            ans[u] = maxProduct;
        }

        // Prepare return value for parent (at most 5 extreme values: 2 smallest, 3 largest)
        const resultExtremes = [];
        if (len >= 1) resultExtremes.push(currentSubtreeValues[0]);
        if (len >= 2) resultExtremes.push(currentSubtreeValues[1]);

        // Add largest three, ensuring we don't go out of bounds for small 'len'
        if (len >= 3) resultExtremes.push(currentSubtreeValues[len - 3]);
        if (len >= 2) resultExtremes.push(currentSubtreeValues[len - 2]);
        if (len >= 1) resultExtremes.push(currentSubtreeValues[len - 1]);

        // Use a Set to remove duplicates (important for small 'len') and then sort
        const uniqueExtremes = Array.from(new Set(resultExtremes));
        uniqueExtremes.sort((a, b) => {
            if (a < b) return -1;
            if (a > b) return 1;
            return 0;
        });

        return uniqueExtremes;
    }

    dfs(0, -1); // Start DFS from node 0, with -1 as its parent

    return ans;
};