var increasingBST = function(root) {
    const dummy = new TreeNode(-1);
    let current = dummy;

    const inorder = (node) => {
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