var buildTree = function(inorder, postorder) {
    if (!inorder || !postorder || inorder.length === 0 || postorder.length === 0) {
        return null;
    }

    const map = new Map();
    for (let i = 0; i < inorder.length; i++) {
        map.set(inorder[i], i);
    }

    const helper = function(postStart, inStart, inEnd) {
        if (inStart > inEnd) {
            return null;
        }

        const rootVal = postorder[postStart];
        const root = new TreeNode(rootVal);
        const rootIndex = map.get(rootVal);

        const rightSubtreeSize = inEnd - rootIndex;

        root.right = helper(postStart - 1, rootIndex + 1, inEnd);
        root.left = helper(postStart - rightSubtreeSize - 1, inStart, rootIndex - 1);

        return root;
    };

    return helper(postorder.length - 1, 0, inorder.length - 1);
};