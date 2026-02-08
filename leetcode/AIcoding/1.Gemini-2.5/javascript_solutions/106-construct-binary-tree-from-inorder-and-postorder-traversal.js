var buildTree = function(inorder, postorder) {
    const inorderMap = new Map();
    for (let i = 0; i < inorder.length; i++) {
        inorderMap.set(inorder[i], i);
    }

    function build(inorderStart, inorderEnd, postorderStart, postorderEnd) {
        if (inorderStart > inorderEnd || postorderStart > postorderEnd) {
            return null;
        }

        const rootVal = postorder[postorderEnd];
        const root = new TreeNode(rootVal);

        const rootInorderIndex = inorderMap.get(rootVal);

        const numLeft = rootInorderIndex - inorderStart;

        root.left = build(
            inorderStart,
            rootInorderIndex - 1,
            postorderStart,
            postorderStart + numLeft - 1
        );

        root.right = build(
            rootInorderIndex + 1,
            inorderEnd,
            postorderStart + numLeft,
            postorderEnd - 1
        );

        return root;
    }

    return build(0, inorder.length - 1, 0, postorder.length - 1);
};