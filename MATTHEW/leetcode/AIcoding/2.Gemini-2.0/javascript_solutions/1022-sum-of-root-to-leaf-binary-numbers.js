var sumRootToLeaf = function(root) {
    let sum = 0;

    function dfs(node, currentNumber) {
        if (!node) {
            return;
        }

        currentNumber = (currentNumber << 1) | node.val;

        if (!node.left && !node.right) {
            sum += currentNumber;
            return;
        }

        dfs(node.left, currentNumber);
        dfs(node.right, currentNumber);
    }

    dfs(root, 0);
    return sum;
};