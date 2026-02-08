var constructFromPrePost = function(preorder, postorder) {
    function buildTree(preStart, preEnd, postStart, postEnd) {
        if (preStart > preEnd) {
            return null;
        }
        if (preStart === preEnd) {
            return new TreeNode(preorder[preStart]);
        }

        const rootVal = preorder[preStart];
        const root = new TreeNode(rootVal);

        const leftRootVal = preorder[preStart + 1];
        let leftRootIndexInPost = postorder.indexOf(leftRootVal);

        const leftSize = leftRootIndexInPost - postStart + 1;

        root.left = buildTree(preStart + 1, preStart + leftSize, postStart, leftRootIndexInPost);
        root.right = buildTree(preStart + leftSize + 1, preEnd, leftRootIndexInPost + 1, postEnd - 1);

        return root;
    }

    return buildTree(0, preorder.length - 1, 0, postorder.length - 1);
};