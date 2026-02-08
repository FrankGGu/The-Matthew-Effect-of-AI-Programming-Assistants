var distributeCoins = function(root) {
    let totalMoves = 0;

    function dfs(node) {
        if (!node) {
            return 0;
        }

        let leftBalance = dfs(node.left);
        let rightBalance = dfs(node.right);

        totalMoves += Math.abs(leftBalance) + Math.abs(rightBalance);

        return node.val + leftBalance + rightBalance - 1;
    }

    dfs(root);
    return totalMoves;
};