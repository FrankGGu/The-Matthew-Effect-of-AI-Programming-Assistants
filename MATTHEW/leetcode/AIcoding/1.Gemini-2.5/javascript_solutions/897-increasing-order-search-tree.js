var increasingBST = function(root) {
    let dummy = new TreeNode(0);
    let current = dummy;

    function inorder(node) {
        if (!node) {
            return;
        }

        inorder(node.left);

        current.right = node;
        node.left = null;
        current = node;

        inorder(node.right);
    }

    inorder(root);
    return dummy.right;
};