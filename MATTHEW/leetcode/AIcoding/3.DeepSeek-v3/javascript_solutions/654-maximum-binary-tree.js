var constructMaximumBinaryTree = function(nums) {
    if (!nums.length) return null;

    const max = Math.max(...nums);
    const maxIndex = nums.indexOf(max);

    const root = new TreeNode(max);
    root.left = constructMaximumBinaryTree(nums.slice(0, maxIndex));
    root.right = constructMaximumBinaryTree(nums.slice(maxIndex + 1));

    return root;
};