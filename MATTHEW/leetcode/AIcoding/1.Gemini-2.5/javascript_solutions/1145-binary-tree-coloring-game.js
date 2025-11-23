var btreeGameWinningStrategy = function(root, n, x) {
    let leftSize = 0;
    let rightSize = 0;

    const dfs = (node) => {
        if (!node) {
            return 0;
        }

        const lCount = dfs(node.left);
        const rCount = dfs(node.right);

        if (node.val === x) {
            leftSize = lCount;
            rightSize = rCount;
        }

        return 1 + lCount + rCount;
    };

    dfs(root);

    const parentSize = n - (1 + leftSize + rightSize);

    return leftSize > n / 2 || rightSize > n / 2 || parentSize > n / 2;
};