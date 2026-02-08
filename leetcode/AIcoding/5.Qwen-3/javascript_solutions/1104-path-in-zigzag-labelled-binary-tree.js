function pathInZigzagLabelledBinaryTree(n) {
    const path = [];
    while (n > 0) {
        path.unshift(n);
        n = Math.floor((n - 1) / 2);
    }
    return path;
}