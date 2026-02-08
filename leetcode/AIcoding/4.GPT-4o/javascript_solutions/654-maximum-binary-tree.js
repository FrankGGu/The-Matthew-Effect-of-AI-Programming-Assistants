class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

var constructMaximumBinaryTree = function(nums) {
    if (nums.length === 0) return null;

    let maxIndex = nums.indexOf(Math.max(...nums));
    let root = new TreeNode(nums[maxIndex]);

    root.left = constructMaximumBinaryTree(nums.slice(0, maxIndex));
    root.right = constructMaximumBinaryTree(nums.slice(maxIndex + 1));

    return root;
};