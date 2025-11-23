var insertIntoMaxTree = function(root, val) {
    if (root === null) {
        return new TreeNode(val);
    }

    if (val > root.val) {
        const newRoot = new TreeNode(val);
        newRoot.left = root;
        return newRoot;
    } else {
        root.right = insertIntoMaxTree(root.right, val);
        return root;
    }
};