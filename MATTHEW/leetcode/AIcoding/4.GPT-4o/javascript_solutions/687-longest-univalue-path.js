class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var longestUnivaluePath = function(root) {
    let maxLength = 0;

    const dfs = (node) => {
        if (!node) return 0;
        let leftLength = dfs(node.left);
        let rightLength = dfs(node.right);
        let leftPath = 0, rightPath = 0;

        if (node.left && node.left.val === node.val) {
            leftPath = leftLength + 1;
        }
        if (node.right && node.right.val === node.val) {
            rightPath = rightLength + 1;
        }

        maxLength = Math.max(maxLength, leftPath + rightPath);
        return Math.max(leftPath, rightPath);
    };

    dfs(root);
    return maxLength;
};