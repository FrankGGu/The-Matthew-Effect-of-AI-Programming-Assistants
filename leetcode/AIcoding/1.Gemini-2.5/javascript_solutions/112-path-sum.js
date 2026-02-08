var hasPathSum = function(root, targetSum) {
    if (!root) {
        return false;
    }

    if (!root.left && !root.right) {
        return targetSum === root.val;
    }

    const remainingSum = targetSum - root.val;
    return hasPathSum(root.left, remainingSum) || hasPathSum(root.right, remainingSum);
};