var treeHeightAfterRemovingQueries = function(root, queries) {
    const N = 100001; // Max possible node value + 1, as per constraints n <= 10^5
    const height = new Array(N).fill(-1); // height[node.val] stores height of subtree rooted at node
    const ans = new Array(N).fill(-1); // ans[node.val] stores the result for query node.val

    // DFS1: Calculate height for each node
    // This is a post-order traversal.
    // height[node.val] will store the height of the subtree rooted at 'node'.
    // A single node has height 0. An empty tree has height -1.
    function dfs1(node) {
        if (!node) {
            return -1;
        }

        const leftHeight = dfs1(node.left);
        const rightHeight = dfs1(node.right);

        height[node.val] = Math.max(leftHeight, rightHeight) + 1;
        return height[node.val];
    }

    // DFS2: Calculate the maximum height of the tree if the current node's subtree is removed.
    // This is a pre-order traversal.
    // `currentMaxHeightExcludingThisSubtree` represents the maximum height of the tree
    // if the current `node`'s subtree is removed, considering only its ancestors and siblings.
    // For the root, this value is -1 (as removing root results in an empty tree).
    function dfs2(node, currentMaxHeightExcludingThisSubtree) {
        if (!node) {
            return;
        }

        ans[node.val] = currentMaxHeightExcludingThisSubtree;

        const leftSubtreeHeight = node.left ? height[node.left.val] : -1;
        const rightSubtreeHeight = node.right ? height[node.right.val] : -1;

        // When traversing to the left child:
        // The new `currentMaxHeightExcludingThisSubtree` for the left child will be
        // the maximum of:
        // 1. The height from its parent's perspective (currentMaxHeightExcludingThisSubtree + 1).
        // 2. The height of its right sibling's subtree (rightSubtreeHeight + 1).
        if (node.left) {
            const newMaxHeightForLeftChild = Math.max(currentMaxHeightExcludingThisSubtree + 1, rightSubtreeHeight + 1);
            dfs2(node.left, newMaxHeightForLeftChild);
        }

        // When traversing to the right child:
        // The new `currentMaxHeightExcludingThisSubtree` for the right child will be
        // the maximum of:
        // 1. The height from its parent's perspective (currentMaxHeightExcludingThisSubtree + 1).
        // 2. The height of its left sibling's subtree (leftSubtreeHeight + 1).
        if (node.right) {
            const newMaxHeightForRightChild = Math.max(currentMaxHeightExcludingThisSubtree + 1, leftSubtreeHeight + 1);
            dfs2(node.right, newMaxHeightForRightChild);
        }
    }

    // First pass: calculate height for all subtrees
    dfs1(root);

    // Second pass: calculate the answer for each node if its subtree is removed
    // Start with root, if root is removed, the tree becomes empty, so its height is -1.
    dfs2(root, -1); 

    // Collect results for the given queries
    const result = [];
    for (const queryVal of queries) {
        result.push(ans[queryVal]);
    }

    return result;
};