var bstFromPreorder = function(preorder) {
    if (!preorder.length) return null;
    const root = new TreeNode(preorder[0]);
    let i = 1;
    while (i < preorder.length && preorder[i] < root.val) {
        i++;
    }
    root.left = bstFromPreorder(preorder.slice(1, i));
    root.right = bstFromPreorder(preorder.slice(i));
    return root;
};