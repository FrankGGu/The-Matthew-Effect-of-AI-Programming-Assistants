var increasingBST = function(root) {
    let result = null;
    let current = null;

    function inorder(node) {
        if (!node) return;

        inorder(node.left);

        if (!result) {
            result = node;
            current = node;
        } else {
            current.right = node;
            current = node;
        }

        node.left = null;

        inorder(node.right);
    }

    inorder(root);

    return result;
};