var maximizeTheTargetNodes = function(root1, root2) {
    const dfs = (node) => {
        if (!node) return 0;
        let left = dfs(node.left);
        let right = dfs(node.right);
        return left + right + 1;
    };

    const count1 = dfs(root1);
    const count2 = dfs(root2);

    return count1 + count2;
};