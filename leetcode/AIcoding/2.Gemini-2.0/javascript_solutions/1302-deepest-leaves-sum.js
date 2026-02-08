var deepestLeavesSum = function(root) {
    let maxDepth = 0;
    let sum = 0;

    function dfs(node, depth) {
        if (!node) {
            return;
        }

        if (!node.left && !node.right) {
            if (depth > maxDepth) {
                maxDepth = depth;
                sum = node.val;
            } else if (depth === maxDepth) {
                sum += node.val;
            }
            return;
        }

        dfs(node.left, depth + 1);
        dfs(node.right, depth + 1);
    }

    dfs(root, 1);
    return sum;
};