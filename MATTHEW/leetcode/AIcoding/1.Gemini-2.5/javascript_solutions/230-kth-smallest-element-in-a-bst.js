var kthSmallest = function(root, k) {
    let count = 0;
    let result = null;

    function inorder(node) {
        if (!node || result !== null) {
            return;
        }

        inorder(node.left);

        if (result !== null) {
            return;
        }

        count++;
        if (count === k) {
            result = node.val;
            return;
        }

        inorder(node.right);
    }

    inorder(root);
    return result;
};