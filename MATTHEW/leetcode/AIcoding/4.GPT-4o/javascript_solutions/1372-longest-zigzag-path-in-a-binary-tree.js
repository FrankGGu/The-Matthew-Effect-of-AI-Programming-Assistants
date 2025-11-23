class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = this.right = null;
    }
}

var longestZigZag = function(root) {
    let maxLength = 0;

    const dfs = (node, isLeft, length) => {
        if (!node) return;
        maxLength = Math.max(maxLength, length);
        if (isLeft) {
            dfs(node.left, false, length + 1);
            dfs(node.right, true, 1);
        } else {
            dfs(node.right, true, length + 1);
            dfs(node.left, false, 1);
        }
    };

    dfs(root, true, 0);
    dfs(root, false, 0);
    return maxLength;
};