var maxSumBST = function(root) {
    let maxSum = 0;

    function traverse(node) {
        if (!node) {
            return [true, Infinity, -Infinity, 0]; // isBST, min, max, sum
        }

        let left = traverse(node.left);
        let right = traverse(node.right);

        if (left[0] && right[0] && node.val > left[2] && node.val < right[1]) {
            let sum = left[3] + right[3] + node.val;
            maxSum = Math.max(maxSum, sum);
            return [true, Math.min(left[1], node.val), Math.max(right[2], node.val), sum];
        } else {
            return [false, -Infinity, Infinity, 0];
        }
    }

    traverse(root);
    return maxSum;
};