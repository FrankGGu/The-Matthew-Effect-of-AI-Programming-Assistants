var averageOfSubtree = function(root) {
    let count = 0;

    function dfs(node) {
        if (!node) {
            return [0, 0];
        }

        const [leftSum, leftCount] = dfs(node.left);
        const [rightSum, rightCount] = dfs(node.right);

        const currentSum = node.val + leftSum + rightSum;
        const currentCount = 1 + leftCount + rightCount;

        if (Math.floor(currentSum / currentCount) === node.val) {
            count++;
        }

        return [currentSum, currentCount];
    }

    dfs(root);
    return count;
};