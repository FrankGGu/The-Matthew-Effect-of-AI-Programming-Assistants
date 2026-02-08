var sumOfLeftLeaves = function(root) {
    if (!root) {
        return 0;
    }

    let totalSum = 0;

    if (root.left) {
        // Check if the left child is a leaf
        if (!root.left.left && !root.left.right) {
            totalSum += root.left.val;
        } else {
            // If it's not a leaf, recurse on the left subtree
            totalSum += sumOfLeftLeaves(root.left);
        }
    }

    // Always recurse on the right subtree
    totalSum += sumOfLeftLeaves(root.right);

    return totalSum;
};