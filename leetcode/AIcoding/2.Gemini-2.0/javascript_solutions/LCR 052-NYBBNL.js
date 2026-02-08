var increasingBST = function(root) {
    let dummy = new TreeNode(0);
    let current = dummy;
    let stack = [];
    let node = root;

    while (node || stack.length) {
        while (node) {
            stack.push(node);
            node = node.left;
        }

        node = stack.pop();
        current.right = new TreeNode(node.val);
        current = current.right;
        node = node.right;
    }

    return dummy.right;
};