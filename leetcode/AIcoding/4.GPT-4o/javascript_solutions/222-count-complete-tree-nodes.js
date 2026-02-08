var countNodes = function(root) {
    if (!root) return 0;

    let leftDepth = 0;
    let rightDepth = 0;
    let node = root;

    while (node) {
        leftDepth++;
        node = node.left;
    }

    node = root;
    while (node) {
        rightDepth++;
        node = node.right;
    }

    if (leftDepth === rightDepth) {
        return (1 << leftDepth) - 1;
    }

    return 1 + countNodes(root.left) + countNodes(root.right);
};