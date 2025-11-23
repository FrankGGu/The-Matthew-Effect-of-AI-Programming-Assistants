var convertBST = function(root) {
    let sum = 0;
    const dfs = function(node) {
        if (!node) return;
        dfs(node.right);
        sum += node.val;
        node.val = sum;
        dfs(node.left);
    };
    dfs(root);
    return root;
};