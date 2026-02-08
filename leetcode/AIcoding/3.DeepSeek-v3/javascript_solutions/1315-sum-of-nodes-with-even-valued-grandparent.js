var sumEvenGrandparent = function(root) {
    let sum = 0;

    const dfs = (node, parent, grandparent) => {
        if (!node) return;

        if (grandparent && grandparent.val % 2 === 0) {
            sum += node.val;
        }

        dfs(node.left, node, parent);
        dfs(node.right, node, parent);
    };

    dfs(root, null, null);
    return sum;
};