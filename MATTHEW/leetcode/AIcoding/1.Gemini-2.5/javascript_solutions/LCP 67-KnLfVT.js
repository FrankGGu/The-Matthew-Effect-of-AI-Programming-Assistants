var decorateTree = function(root) {
    if (!root) {
        return null;
    }

    function dfs(node) {
        if (!node.left && !node.right) {
            node.val = 1;
            return 1;
        }

        let leftVal = 0;
        if (node.left) {
            leftVal = dfs(node.left);
        }

        let rightVal = 0;
        if (node.right) {
            rightVal = dfs(node.right);
        }

        node.val = leftVal + rightVal;
        return node.val;
    }

    dfs(root);
    return root;
};