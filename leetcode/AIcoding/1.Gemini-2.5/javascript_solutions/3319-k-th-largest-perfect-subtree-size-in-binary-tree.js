var kthLargestPerfectSubtreeSize = function(root, k) {
    let perfectSizes = [];

    function dfs(node) {
        if (!node) {
            return [true, -1, 0];
        }

        let [leftPerfect, leftHeight, leftSize] = dfs(node.left);
        let [rightPerfect, rightHeight, rightSize] = dfs(node.right);

        let currentHeight = Math.max(leftHeight, rightHeight) + 1;
        let currentSize = leftSize + rightSize + 1;
        let currentIsPerfect = leftPerfect && rightPerfect && (leftHeight === rightHeight);

        if (currentIsPerfect) {
            perfectSizes.push(currentSize);
        }

        return [currentIsPerfect, currentHeight, currentSize];
    }

    dfs(root);

    perfectSizes.sort((a, b) => b - a);

    return perfectSizes[k - 1];
};