function buildTree(preorder, inorder) {
    if (!preorder.length || !inorder.length) return null;

    const rootValue = preorder[0];
    const root = new TreeNode(rootValue);
    const rootIndexInInorder = inorder.indexOf(rootValue);

    root.left = buildTree(preorder.slice(1, rootIndexInInorder + 1), inorder.slice(0, rootIndexInInorder));
    root.right = buildTree(preorder.slice(rootIndexInInorder + 1), inorder.slice(rootIndexInInorder + 1));

    return root;
}