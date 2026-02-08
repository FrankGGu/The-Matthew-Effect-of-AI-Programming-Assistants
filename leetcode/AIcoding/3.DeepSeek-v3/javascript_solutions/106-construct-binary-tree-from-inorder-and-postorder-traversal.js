var buildTree = function(inorder, postorder) {
    const map = {};
    for (let i = 0; i < inorder.length; i++) {
        map[inorder[i]] = i;
    }

    const helper = (inStart, inEnd, postStart, postEnd) => {
        if (inStart > inEnd || postStart > postEnd) return null;

        const rootVal = postorder[postEnd];
        const root = new TreeNode(rootVal);
        const inRoot = map[rootVal];
        const numsRight = inEnd - inRoot;

        root.left = helper(inStart, inRoot - 1, postStart, postEnd - numsRight - 1);
        root.right = helper(inRoot + 1, inEnd, postEnd - numsRight, postEnd - 1);

        return root;
    };

    return helper(0, inorder.length - 1, 0, postorder.length - 1);
};