var bstToGst = function(root) {
    let sum = 0;
    const traverse = (node) => {
        if (node === null) return;
        traverse(node.right);
        sum += node.val;
        node.val = sum;
        traverse(node.left);
    };
    traverse(root);
    return root;
};