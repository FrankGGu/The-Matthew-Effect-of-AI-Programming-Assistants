var buildTree = function(inorder, postorder) {
    if (!inorder || inorder.length === 0) {
        return null;
    }

    let postorderIndex = postorder.length - 1;

    const build = (inorderStart, inorderEnd) => {
        if (inorderStart > inorderEnd) {
            return null;
        }

        const rootVal = postorder[postorderIndex];
        const root = new TreeNode(rootVal);

        const inorderIndex = inorder.indexOf(rootVal);
        postorderIndex--;

        root.right = build(inorderIndex + 1, inorderEnd);
        root.left = build(inorderStart, inorderIndex - 1);

        return root;
    };

    return build(0, inorder.length - 1);
};