var insertIntoMaxTree = function(root, val) {
    if (!root || val > root.val) {
        let newNode = new TreeNode(val);
        newNode.left = root;
        return newNode;
    }
    root.right = insertIntoMaxTree(root.right, val);
    return root;
};