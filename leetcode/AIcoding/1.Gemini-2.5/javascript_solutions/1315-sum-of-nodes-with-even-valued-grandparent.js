var sumEvenGrandparent = function(root) {
    let totalSum = 0;

    function dfs(node, parentVal, grandparentVal) {
        if (!node) {
            return;
        }

        if (grandparentVal !== -1 && grandparentVal % 2 === 0) {
            totalSum += node.val;
        }

        dfs(node.left, node.val, parentVal);
        dfs(node.right, node.val, parentVal);
    }

    dfs(root, -1, -1);
    return totalSum;
};