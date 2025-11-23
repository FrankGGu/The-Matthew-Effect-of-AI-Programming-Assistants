var searchBST = function(root, val) {
    while (root !== null) {
        if (val === root.val) {
            return root;
        } else if (val < root.val) {
            root = root.left;
        } else {
            root = root.right;
        }
    }
    return null;
};