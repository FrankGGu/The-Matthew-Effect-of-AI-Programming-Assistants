var sortedArrayToBST = function(nums) {
    function buildTree(left, right) {
        if (left > right) return null;
        const mid = Math.floor((left + right) / 2);
        const node = new TreeNode(nums[mid]);
        node.left = buildTree(left, mid - 1);
        node.right = buildTree(mid + 1, right);
        return node;
    }
    return buildTree(0, nums.length - 1);
};