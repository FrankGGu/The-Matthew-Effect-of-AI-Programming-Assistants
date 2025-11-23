class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var maxSum = function(root) {
    let maxSum = 0;

    const dfs = (node) => {
        if (!node) return 0;
        let left = Math.max(0, dfs(node.left));
        let right = Math.max(0, dfs(node.right));
        maxSum = Math.max(maxSum, left + right + node.val);
        return Math.max(left, right) + node.val;
    };

    dfs(root);
    return maxSum;
};