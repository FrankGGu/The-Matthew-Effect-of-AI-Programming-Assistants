var sumEvenGrandparent = function(root) {
    let sum = 0;

    function dfs(node, parentVal, grandparentVal) {
        if (!node) {
            return;
        }

        if (grandparentVal % 2 === 0) {
            sum += node.val;
        }

        dfs(node.left, node.val, parentVal);
        dfs(node.right, node.val, parentVal);
    }

    dfs(root, 1, 1); 

    return sum;
};