var constructFromPrePost = function(pre, post) {
    if (pre.length === 0) return null;
    const root = new TreeNode(pre[0]);
    if (pre.length === 1) return root;

    const leftRootIdx = pre[1];
    const leftSubtreeSize = post.indexOf(leftRootIdx) + 1;

    root.left = constructFromPrePost(pre.slice(1, leftSubtreeSize + 1), post.slice(0, leftSubtreeSize));
    root.right = constructFromPrePost(pre.slice(leftSubtreeSize + 1), post.slice(leftSubtreeSize, post.length - 1));

    return root;
};