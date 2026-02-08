function btreeGameWinningSize(root) {
    function dfs(node) {
        if (!node) return 0;
        const left = dfs(node.left);
        const right = dfs(node.right);
        const total = left + right + 1;
        if (left > total / 2 || right > total / 2 || total - left - 1 > total / 2) {
            return total;
        }
        return total;
    }

    return dfs(root);
}