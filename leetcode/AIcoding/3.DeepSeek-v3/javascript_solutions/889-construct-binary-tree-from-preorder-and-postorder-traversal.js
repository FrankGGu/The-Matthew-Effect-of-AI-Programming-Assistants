var constructFromPrePost = function(pre, post) {
    if (!pre.length || !post.length) return null;
    let root = new TreeNode(pre[0]);
    if (pre.length === 1) return root;

    let leftVal = pre[1];
    let leftPostIdx = post.indexOf(leftVal);
    let leftPost = post.slice(0, leftPostIdx + 1);
    let rightPost = post.slice(leftPostIdx + 1, post.length - 1);

    let leftPre = pre.slice(1, leftPost.length + 1);
    let rightPre = pre.slice(leftPost.length + 1);

    root.left = constructFromPrePost(leftPre, leftPost);
    root.right = constructFromPrePost(rightPre, rightPost);

    return root;
};