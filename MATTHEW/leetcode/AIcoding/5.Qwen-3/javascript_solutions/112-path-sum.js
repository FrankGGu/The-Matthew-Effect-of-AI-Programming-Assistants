function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

function hasPathSum(root, targetSum) {
    if (root === null) return false;
    if (root.left === null && root.right === null) return root.val === targetSum;
    return hasPathSum(root.left, targetSum - root.val) || hasPathSum(root.right, targetSum - root.val);
}