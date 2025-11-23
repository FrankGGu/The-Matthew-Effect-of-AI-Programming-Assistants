var buildTree = function(preorder, inorder) {
    if (!preorder.length || !inorder.length) return null;

    const map = new Map();
    for (let i = 0; i < inorder.length; i++) {
        map.set(inorder[i], i);
    }

    const helper = function(preStart, inStart, inEnd) {
        if (preStart > preorder.length - 1 || inStart > inEnd) return null;

        const rootVal = preorder[preStart];
        const root = new TreeNode(rootVal);
        const rootIndex = map.get(rootVal);

        const leftSubtreeSize = rootIndex - inStart;

        root.left = helper(preStart + 1, inStart, rootIndex - 1);
        root.right = helper(preStart + 1 + leftSubtreeSize, rootIndex + 1, inEnd);

        return root;
    };

    return helper(0, 0, inorder.length - 1);
};