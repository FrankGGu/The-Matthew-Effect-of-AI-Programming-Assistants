class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var addOneRow = function(root, val, depth) {
    if (depth === 1) {
        return new TreeNode(val, root, null);
    }

    const dfs = (node, currentDepth) => {
        if (!node) return;
        if (currentDepth === depth - 1) {
            node.left = new TreeNode(val, node.left, null);
            node.right = new TreeNode(val, null, node.right);
        } else {
            dfs(node.left, currentDepth + 1);
            dfs(node.right, currentDepth + 1);
        }
    };

    dfs(root, 1);
    return root;
};