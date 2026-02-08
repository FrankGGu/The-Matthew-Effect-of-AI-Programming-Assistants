var sumEvenGrandparent = function(root) {
    let sum = 0;

    function dfs(node, parent, grandparent) {
        if (!node) return;

        if (grandparent % 2 === 0) {
            sum += node.val;
        }

        dfs(node.left, node.val, parent);
        dfs(node.right, node.val, parent);
    }

    dfs(root, null, null);
    return sum;
};