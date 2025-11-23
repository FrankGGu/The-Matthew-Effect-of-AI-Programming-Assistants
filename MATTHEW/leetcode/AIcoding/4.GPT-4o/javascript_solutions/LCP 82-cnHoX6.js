var countNodes = function(root) {
    if (!root) return 0;

    let left = root, right = root;
    let leftHeight = 0, rightHeight = 0;

    while (left) {
        leftHeight++;
        left = left.left;
    }

    while (right) {
        rightHeight++;
        right = right.right;
    }

    if (leftHeight === rightHeight) {
        return (1 << leftHeight) - 1;
    }

    return 1 + countNodes(root.left) + countNodes(root.right);
};