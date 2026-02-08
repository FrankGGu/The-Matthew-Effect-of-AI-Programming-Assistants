function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var lcaDeepestLeaves = function(root) {
    const dfs = (node) => {
        if (!node) return [null, 0];
        const [leftLca, leftDepth] = dfs(node.left);
        const [rightLca, rightDepth] = dfs(node.right);

        if (leftDepth === rightDepth) {
            return [node, leftDepth + 1];
        } else if (leftDepth > rightDepth) {
            return [leftLca, leftDepth + 1];
        } else {
            return [rightLca, rightDepth + 1];
        }
    };

    return dfs(root)[0];
};