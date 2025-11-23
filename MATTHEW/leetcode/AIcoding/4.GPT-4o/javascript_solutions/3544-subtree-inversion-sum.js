var subtreeInversionSum = function(root) {
    let totalSum = 0;

    const invertAndSum = (node) => {
        if (!node) return 0;
        let leftSum = invertAndSum(node.left);
        let rightSum = invertAndSum(node.right);
        totalSum += node.val;
        node.left = rightSum;
        node.right = leftSum;
        return node.val + leftSum + rightSum;
    };

    invertAndSum(root);
    return totalSum;
};