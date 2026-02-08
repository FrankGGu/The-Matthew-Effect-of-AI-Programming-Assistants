function minDepth(root) {
    if (!root) return 0;
    if (!root.left && !root.right) return 1;

    let leftDepth = root.left ? minDepth(root.left) : Infinity;
    let rightDepth = root.right ? minDepth(root.right) : Infinity;

    return Math.min(leftDepth, rightDepth) + 1;
}