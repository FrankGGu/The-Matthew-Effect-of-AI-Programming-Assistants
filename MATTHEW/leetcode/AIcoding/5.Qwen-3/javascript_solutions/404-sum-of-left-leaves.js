function sumOfLeftLeaves(root) {
    if (!root) return 0;

    let sum = 0;

    function dfs(node, isLeft) {
        if (!node) return;
        if (isLeft && !node.left && !node.right) {
            sum += node.val;
            return;
        }
        dfs(node.left, true);
        dfs(node.right, false);
    }

    dfs(root, false);
    return sum;
}