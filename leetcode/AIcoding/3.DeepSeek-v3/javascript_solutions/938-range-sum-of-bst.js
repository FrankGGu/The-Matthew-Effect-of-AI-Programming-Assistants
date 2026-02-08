var rangeSumBST = function(root, low, high) {
    let sum = 0;
    const stack = [root];

    while (stack.length > 0) {
        const node = stack.pop();
        if (!node) continue;

        if (node.val >= low && node.val <= high) {
            sum += node.val;
        }

        if (node.val > low) {
            stack.push(node.left);
        }

        if (node.val < high) {
            stack.push(node.right);
        }
    }

    return sum;
};