function createComponentsWithSameValue(nums, edges) {
    const n = nums.length;
    const adj = Array(n).fill(0).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const totalSum = nums.reduce((acc, val) => acc + val, 0);

    // Find all divisors of totalSum
    const divisors = [];
    for (let i = 1; i * i <= totalSum; i++) {
        if (totalSum % i === 0) {
            divisors.push(i);
            if (i * i !== totalSum) {
                divisors.push(totalSum / i);
            }
        }
    }
    // Sort divisors in ascending order.
    // This ensures that when we iterate, the corresponding 'k' (totalSum / s) values are in descending order.
    // The first 's' that works will yield the maximum 'k'.
    divisors.sort((a, b) => a - b);

    for (const s of divisors) {
        const k = totalSum / s;

        let componentCount = 0; // Counter for components found for the current target sum 's'

        // DFS function to check if the tree can be partitioned into components of 'targetSum'.
        // It returns:
        // - The sum of the current incomplete component being built, if successful so far.
        // - 0 if the current subtree forms a complete component of 'targetSum'.
        // - -1 if it's impossible to form components of 'targetSum' within this subtree.
        const dfs = (u, p, targetSum) => {
            let currentSubtreeSum = nums[u];

            for (const v of adj[u]) {
                if (v === p) continue;

                const childSum = dfs(v, u, targetSum);

                // If any child subtree cannot form components of targetSum, then this path is invalid
                if (childSum === -1) {
                    return -1;
                }
                currentSubtreeSum += childSum;
            }

            // If the current subtree sum equals the target sum, we've found a valid component.
            // Increment the component counter and effectively "cut" this component by returning 0 to its parent.
            if (currentSubtreeSum === targetSum) {
                componentCount++;
                return 0;
            }

            // If the current subtree sum exceeds the target sum, it's impossible to form valid components.
            if (currentSubtreeSum > targetSum) {
                return -1;
            }

            // Otherwise, this subtree contributes its sum to its parent to continue building a component.
            return currentSubtreeSum;
        };

        // Start DFS from node 0 (arbitrary root, tree is connected)
        // The result 'remainingSum' should be 0 if the entire tree was successfully partitioned,
        // meaning the root component itself was also cut.
        const remainingSum = dfs(0, -1, s);

        // A valid partition requires:
        // 1. The DFS completed without returning -1 (remainingSum is not -1).
        // 2. The final remaining sum from the root is 0, indicating the root itself formed a component.
        // 3. The number of components found matches the expected 'k'.
        if (remainingSum === 0 && componentCount === k) {
            // Since we iterate 's' in ascending order, the corresponding 'k' (totalSum / s)
            // will be in descending order. The first valid 'k' we find will be the maximum.
            return k; 
        }
    }

    // If no valid partition is found for any s, it means only the entire tree itself (k=1) is possible.
    return 1;
}