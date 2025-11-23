var increasingBST = function(root) {
    let res = [];

    const inorder = (node) => {
        if (!node) return;
        inorder(node.left);
        res.push(node.val);
        inorder(node.right);
    };

    inorder(root);

    let newRoot = new TreeNode(res[0]);
    let curr = newRoot;

    for (let i = 1; i < res.length; i++) {
        curr.right = new TreeNode(res[i]);
        curr = curr.right;
    }

    return newRoot;
};