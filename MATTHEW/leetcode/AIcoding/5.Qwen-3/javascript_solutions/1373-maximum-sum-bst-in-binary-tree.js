function maxSumBST(root) {
    let maxSum = 0;

    function helper(node) {
        if (!node) return [true, 0, Number.MAX_VALUE, Number.MIN_VALUE];

        const left = helper(node.left);
        const right = helper(node.right);

        if (left[0] && right[0] && node.val > left[3] && node.val < right[2]) {
            const sum = left[1] + right[1] + node.val;
            maxSum = Math.max(maxSum, sum);
            return [true, sum, Math.min(left[2], node.val), Math.max(right[3], node.val)];
        } else {
            return [false, 0, 0, 0];
        }
    }

    helper(root);
    return maxSum;
}