var bstFromPreorder = function(preorder) {
    let idx = 0;
    const n = preorder.length;

    function dfs(upperBound) {
        if (idx === n || preorder[idx] > upperBound) {
            return null;
        }

        const node = new TreeNode(preorder[idx]);
        idx++;

        node.left = dfs(node.val);
        node.right = dfs(upperBound);

        return node;
    }

    return dfs(Infinity);
};