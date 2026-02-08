var buildTree = function(preorder, inorder) {
    const inorderMap = new Map();
    for (let i = 0; i < inorder.length; i++) {
        inorderMap.set(inorder[i], i);
    }

    function build(preStart, preEnd, inStart, inEnd) {
        if (preStart > preEnd || inStart > inEnd) {
            return null;
        }

        const rootVal = preorder[preStart];
        const root = new TreeNode(rootVal);

        const rootInorderIndex = inorderMap.get(rootVal);
        const leftSubtreeSize = rootInorderIndex - inStart;

        root.left = build(
            preStart + 1,
            preStart + leftSubtreeSize,
            inStart,
            rootInorderIndex - 1
        );

        root.right = build(
            preStart + leftSubtreeSize + 1,
            preEnd,
            rootInorderIndex + 1,
            inEnd
        );

        return root;
    }

    return build(0, preorder.length - 1, 0, inorder.length - 1);
};