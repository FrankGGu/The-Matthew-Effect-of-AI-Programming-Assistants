var insertIntoMaxTree = function(root, val) {
    const newNode = new TreeNode(val);

    if (!root || val > root.val) {
        newNode.left = root;
        return newNode;
    }

    let curr = root;
    while (curr.right && val < curr.right.val) {
        curr = curr.right;
    }

    newNode.left = curr.right;
    curr.right = newNode;

    return root;
};