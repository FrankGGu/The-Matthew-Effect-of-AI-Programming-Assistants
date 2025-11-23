class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var subtreeWithAllDeepest = function(root) {
    const dfs = (node) => {
        if (!node) return [null, 0];
        const [leftNode, leftDepth] = dfs(node.left);
        const [rightNode, rightDepth] = dfs(node.right);

        if (leftDepth > rightDepth) return [leftNode, leftDepth + 1];
        if (rightDepth > leftDepth) return [rightNode, rightDepth + 1];

        return [node, leftDepth + 1];
    };

    return dfs(root)[0];
};