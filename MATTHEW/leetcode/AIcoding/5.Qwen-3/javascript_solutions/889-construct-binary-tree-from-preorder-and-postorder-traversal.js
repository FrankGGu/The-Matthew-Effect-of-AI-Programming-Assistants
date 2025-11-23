var constructFromPrePost = function(preorder, postorder) {
    const map = new Map();
    for (let i = 0; i < postorder.length; i++) {
        map.set(postorder[i], i);
    }

    const helper = (preStart, preEnd, postStart, postEnd) => {
        if (preStart > preEnd) return null;
        if (preStart === preEnd) return new TreeNode(preorder[preStart]);

        const rootVal = preorder[preStart];
        const leftRootVal = preorder[preStart + 1];
        const leftRootIndex = map.get(leftRootVal);

        const leftSubtreeSize = leftRootIndex - postStart + 1;

        const root = new TreeNode(rootVal);
        root.left = helper(preStart + 1, preStart + leftSubtreeSize, postStart, leftRootIndex);
        root.right = helper(preStart + leftSubtreeSize + 1, preEnd, leftRootIndex + 1, postEnd);
        return root;
    };

    return helper(0, preorder.length - 1, 0, postorder.length - 1);
};