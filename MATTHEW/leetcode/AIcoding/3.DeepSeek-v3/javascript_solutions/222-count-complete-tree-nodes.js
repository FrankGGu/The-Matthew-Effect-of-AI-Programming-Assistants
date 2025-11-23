var countNodes = function(root) {
    if (!root) return 0;

    let leftDepth = 0, rightDepth = 0;
    let left = root, right = root;

    while (left) {
        leftDepth++;
        left = left.left;
    }

    while (right) {
        rightDepth++;
        right = right.right;
    }

    if (leftDepth === rightDepth) {
        return Math.pow(2, leftDepth) - 1;
    }

    return 1 + countNodes(root.left) + countNodes(root.right);
};