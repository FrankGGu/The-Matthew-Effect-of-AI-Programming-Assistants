var leafSimilar = function(root1, root2) {
    const getLeafSequence = (root) => {
        const leaves = [];
        const dfs = (node) => {
            if (!node) return;
            if (!node.left && !node.right) {
                leaves.push(node.val);
            }
            dfs(node.left);
            dfs(node.right);
        };
        dfs(root);
        return leaves;
    };

    return JSON.stringify(getLeafSequence(root1)) === JSON.stringify(getLeafSequence(root2));
};