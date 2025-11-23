var maximumScoreAfterApplyingOperations = function(root) {
    function dfs(node) {
        if (!node) return [0, 0];

        if (!node.left && !node.right) {
            return [0, node.val];
        }

        let [left0, left1] = dfs(node.left);
        let [right0, right1] = dfs(node.right);

        let take = Math.max(left0, left1) + Math.max(right0, right1);
        let notTake = node.val + left0 + right0;

        return [take, notTake];
    }

    let [take, notTake] = dfs(root);
    return Math.max(take, notTake);
};