var replaceValueInTree = function(root) {
    if (!root) return null;
    let queue = [root];
    root.val = 0;
    while (queue.length > 0) {
        let nextLevel = [];
        let sum = 0;
        for (let node of queue) {
            if (node.left) {
                nextLevel.push(node.left);
                sum += node.left.val;
            }
            if (node.right) {
                nextLevel.push(node.right);
                sum += node.right.val;
            }
        }
        for (let node of queue) {
            let childrenSum = (node.left ? node.left.val : 0) + (node.right ? node.right.val : 0);
            if (node.left) node.left.val = sum - childrenSum;
            if (node.right) node.right.val = sum - childrenSum;
        }
        queue = nextLevel;
    }
    return root;
};