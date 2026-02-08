function buildTree(inorder, postorder) {
    if (inorder.length === 0) return null;

    const rootVal = postorder.pop();
    const root = new TreeNode(rootVal);
    const index = inorder.indexOf(rootVal);

    root.right = buildTree(inorder.slice(index + 1), postorder);
    root.left = buildTree(inorder.slice(0, index), postorder);

    return root;
}