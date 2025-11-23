function countNodes(root) {
    if (!root) return 0;

    let left = root;
    let right = root;
    let height = 0;

    while (left.left) {
        left = left.left;
        height++;
    }

    while (right.right) {
        right = right.right;
        height++;
    }

    if (left === right) {
        return Math.pow(2, height + 1) - 1;
    }

    return 1 + countNodes(root.left) + countNodes(root.right);
}