var increasingBST = function(root) {
    let dummy = new TreeNode(0);
    let current = dummy;

    const inorder = function(node) {
        if (!node) return;
        inorder(node.left);
        node.left = null;
        current.right = node;
        current = node;
        inorder(node.right);
    };

    inorder(root);
    return dummy.right;
};