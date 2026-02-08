var searchBST = function(root, val) {
    let current = root;
    while (current !== null) {
        if (current.val === val) {
            return current;
        } else if (val < current.val) {
            current = current.left;
        } else {
            current = current.right;
        }
    }
    return null;
};