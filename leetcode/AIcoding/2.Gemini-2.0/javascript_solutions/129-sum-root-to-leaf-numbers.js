var sumNumbers = function(root) {
    let sum = 0;
    const dfs = (node, currentNumber) => {
        if (!node) {
            return;
        }

        currentNumber = currentNumber * 10 + node.val;

        if (!node.left && !node.right) {
            sum += currentNumber;
            return;
        }

        dfs(node.left, currentNumber);
        dfs(node.right, currentNumber);
    };

    dfs(root, 0);
    return sum;
};