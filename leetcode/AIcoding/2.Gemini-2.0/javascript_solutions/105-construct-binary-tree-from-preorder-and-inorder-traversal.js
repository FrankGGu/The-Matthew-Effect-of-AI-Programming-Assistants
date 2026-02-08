var buildTree = function(preorder, inorder) {
    if (!preorder.length || !inorder.length) return null;

    const rootVal = preorder[0];
    const rootIndexInorder = inorder.indexOf(rootVal);

    const root = new TreeNode(rootVal);

    root.left = buildTree(preorder.slice(1, rootIndexInorder + 1), inorder.slice(0, rootIndexInorder));
    root.right = buildTree(preorder.slice(rootIndexInorder + 1), inorder.slice(rootIndexInorder + 1));

    return root;
};