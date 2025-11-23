var maxSumBST = function(root) {
    let maxSum = 0;

    // Helper function performs a post-order traversal.
    // It returns an array: [isBST, minVal, maxVal, sum]
    // - isBST: boolean, true if the subtree rooted at 'node' is a BST.
    // - minVal: number, the minimum value in the BST subtree.
    // - maxVal: number, the maximum value in the BST subtree.
    // - sum: number, the sum of all nodes in the BST subtree.
    //
    // For a null node, it's considered a valid BST with 0 sum,
    // and its min/max values are set to Infinity/-Infinity to not interfere
    // with parent node's BST validation.
    // For a subtree that is not a BST, 'isBST' is false, and other values
    // are set to dummy values (0) as they won't be used for parent validation.
    function dfs(node) {
        if (!node) {
            return [true, Infinity, -Infinity, 0];
        }

        const leftResult = dfs(node.left);
        const rightResult = dfs(node.right);

        const isLeftBST = leftResult[0];
        const leftMax = leftResult[2];
        const leftSum = leftResult[3];

        const isRightBST = rightResult[0];
        const rightMin = rightResult[1];
        const rightSum = rightResult[3];

        // Check if the current subtree rooted at 'node' is a BST
        if (isLeftBST && isRightBST && node.val > leftMax && node.val < rightMin) {
            // If it is a BST, calculate its sum, min, and max
            const currentSum = leftSum + rightSum + node.val;
            maxSum = Math.max(maxSum, currentSum); // Update global maximum sum

            const currentMin = Math.min(leftResult[1], node.val);
            const currentMax = Math.max(rightResult[2], node.val);

            return [true, currentMin, currentMax, currentSum];
        } else {
            // If it's not a BST, propagate false and dummy values
            return [false, 0, 0, 0];
        }
    }

    dfs(root);
    return maxSum;
};