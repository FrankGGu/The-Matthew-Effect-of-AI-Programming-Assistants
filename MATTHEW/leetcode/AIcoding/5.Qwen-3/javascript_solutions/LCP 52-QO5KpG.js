function countNodes(root) {
    if (root === null) return 0;
    let left = root.left;
    let right = root.right;
    let leftDepth = 0;
    let rightDepth = 0;
    while (left) {
        left = left.left;
        leftDepth++;
    }
    while (right) {
        right = right.right;
        rightDepth++;
    }
    if (leftDepth === rightDepth) {
        return (1 << (leftDepth + 1)) - 1;
    } else {
        return 1 + countNodes(root.left) + countNodes(root.right);
    }
}