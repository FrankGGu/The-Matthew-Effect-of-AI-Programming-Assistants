var constructMaximumBinaryTree = function(nums) {
    if (!nums || nums.length === 0) return null;

    function buildTree(arr) {
        if (arr.length === 0) return null;

        let maxVal = Math.max(...arr);
        let index = arr.indexOf(maxVal);

        let root = new TreeNode(maxVal);
        root.left = buildTree(arr.slice(0, index));
        root.right = buildTree(arr.slice(index + 1));

        return root;
    }

    return buildTree(nums);
};