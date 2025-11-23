var findSecondMinimumValue = function(root) {
    let secondMin = -1;
    let firstMin = root.val;

    const traverse = (node) => {
        if (!node) return;
        if (node.val > firstMin) {
            if (secondMin === -1 || node.val < secondMin) {
                secondMin = node.val;
            }
        }
        traverse(node.left);
        traverse(node.right);
    };

    traverse(root);
    return secondMin;
};