function maxProduct(root) {
    const totalSum = dfs(root);
    let maxProduct = 0;
    dfs(root, totalSum, maxProduct);
    return maxProduct;

    function dfs(node, totalSum, maxProduct) {
        if (!node) return 0;
        const left = dfs(node.left, totalSum, maxProduct);
        const right = dfs(node.right, totalSum, maxProduct);
        const currentSum = left + right + node.val;
        maxProduct = Math.max(maxProduct, currentSum * (totalSum - currentSum));
        return currentSum;
    }
}