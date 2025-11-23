function searchBST(root, val) {
    while (root !== null && root.val !== val) {
        root = root.val < val ? root.right : root.left;
    }
    return root;
}