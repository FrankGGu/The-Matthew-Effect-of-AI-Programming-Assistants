var averageOfSubtree = function(root) {
    let count = 0;

    function dfs(node) {
        if (!node) {
            return [0, 0]; // [sum, count]
        }

        let [leftSum, leftCount] = dfs(node.left);
        let [rightSum, rightCount] = dfs(node.right);

        let totalSum = leftSum + rightSum + node.val;
        let totalCount = leftCount + rightCount + 1;

        if (Math.floor(totalSum / totalCount) === node.val) {
            count++;
        }

        return [totalSum, totalCount];
    }

    dfs(root);
    return count;
};