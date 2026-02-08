var buildTree = function(preorder, inorder) {
    if (!preorder.length || !inorder.length) {
        return null;
    }

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

        const rootIdxInInorder = inorderMap.get(rootVal);
        const leftSubtreeSize = rootIdxInInorder - inStart;

        root.left = build(preStart + 1, preStart + leftSubtreeSize, inStart, rootIdxInInorder - 1);
        root.right = build(preStart + leftSubtreeSize + 1, preEnd, rootIdxInInorder + 1, inEnd);

        return root;
    }

    return build(0, preorder.length - 1, 0, inorder.length - 1);
};