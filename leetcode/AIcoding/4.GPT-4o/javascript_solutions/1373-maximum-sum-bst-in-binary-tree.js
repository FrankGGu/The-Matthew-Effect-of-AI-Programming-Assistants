var maxSumBST = function(root) {
    let maxSum = 0;

    function dfs(node) {
        if (!node) return [true, 0, Infinity, -Infinity];

        let left = dfs(node.left);
        let right = dfs(node.right);

        if (left[0] && right[0] && node.val > left[3] && node.val < right[2]) {
            let sum = left[1] + right[1] + node.val;
            maxSum = Math.max(maxSum, sum);
            return [true, sum, Math.min(node.val, left[2]), Math.max(node.val, right[3])];
        }

        return [false, 0, 0, 0];
    }

    dfs(root);
    return maxSum;
};