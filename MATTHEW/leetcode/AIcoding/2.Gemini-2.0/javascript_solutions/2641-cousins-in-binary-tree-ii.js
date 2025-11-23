var replaceValueInTree = function(root) {
    if (!root) return root;

    root.val = 0;
    let queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let levelSum = 0;
        let nextLevel = [];

        for (let i = 0; i < levelSize; i++) {
            let node = queue[i];
            if (node.left) {
                levelSum += node.left.val;
                nextLevel.push(node.left);
            }
            if (node.right) {
                levelSum += node.right.val;
                nextLevel.push(node.right);
            }
        }

        for (let i = 0; i < levelSize; i++) {
            let node = queue[i];
            let siblingSum = 0;
            if (node.left) {
                if (node.right) {
                    siblingSum = node.right.val;
                }
                node.left.val = levelSum - node.left.val - siblingSum;
            }
            if (node.right) {
                if (node.left) {
                    siblingSum = node.left.val;
                }
                node.right.val = levelSum - node.right.val - siblingSum;
            }
        }

        queue = nextLevel;
    }

    return root;
};