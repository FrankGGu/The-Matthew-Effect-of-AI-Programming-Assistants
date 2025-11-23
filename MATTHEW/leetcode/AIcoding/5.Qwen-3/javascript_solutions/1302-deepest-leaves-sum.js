function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}

function deepestLeavesSum(root) {
    let sum = 0;
    let maxDepth = 0;

    function dfs(node, depth) {
        if (!node) return;
        if (depth > maxDepth) {
            maxDepth = depth;
            sum = node.val;
        } else if (depth === maxDepth) {
            sum += node.val;
        }
        dfs(node.left, depth + 1);
        dfs(node.right, depth + 1);
    }

    dfs(root, 0);
    return sum;
}