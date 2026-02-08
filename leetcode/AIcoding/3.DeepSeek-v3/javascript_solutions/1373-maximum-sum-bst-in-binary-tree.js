var maxSumBST = function(root) {
    let maxSum = 0;

    function traverse(node) {
        if (!node) {
            return { isBST: true, min: Infinity, max: -Infinity, sum: 0 };
        }

        let left = traverse(node.left);
        let right = traverse(node.right);

        if (left.isBST && right.isBST && node.val > left.max && node.val < right.min) {
            let sum = node.val + left.sum + right.sum;
            maxSum = Math.max(maxSum, sum);
            return {
                isBST: true,
                min: Math.min(node.val, left.min),
                max: Math.max(node.val, right.max),
                sum: sum
            };
        } else {
            return { isBST: false };
        }
    }

    traverse(root);
    return maxSum;
};