var constructFromPrePost = function(preorder, postorder) {
    if (preorder.length === 0) {
        return null;
    }
    if (preorder.length === 1) {
        return new TreeNode(preorder[0]);
    }

    let rootVal = preorder[0];
    let root = new TreeNode(rootVal);

    let leftRootVal = preorder[1];
    let idx = postorder.indexOf(leftRootVal);
    let leftSubtreeSize = idx + 1;

    let leftPreorder = preorder.slice(1, 1 + leftSubtreeSize);
    let leftPostorder = postorder.slice(0, leftSubtreeSize);
    root.left = constructFromPrePost(leftPreorder, leftPostorder);

    let rightPreorder = preorder.slice(1 + leftSubtreeSize);
    let rightPostorder = postorder.slice(leftSubtreeSize, postorder.length - 1);
    root.right = constructFromPrePost(rightPreorder, rightPostorder);

    return root;
};