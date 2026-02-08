var mergeTrees = function(t1, t2) {
    if (!t1 && !t2) {
        return null;
    }
    if (!t1) {
        return t2;
    }
    if (!t2) {
        return t1;
    }

    const mergedNode = new TreeNode(t1.val + t2.val);
    mergedNode.left = mergeTrees(t1.left, t2.left);
    mergedNode.right = mergeTrees(t1.right, t2.right);

    return mergedNode;
};