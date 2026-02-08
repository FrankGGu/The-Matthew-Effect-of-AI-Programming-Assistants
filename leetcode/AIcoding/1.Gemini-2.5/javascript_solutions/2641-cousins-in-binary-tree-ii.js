var replaceValueInTree = function(root) {
    if (!root) {
        return null;
    }

    root.val = 0;

    let queue = [root];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let nextLevelNodes = [];
        let nextLevelSum = 0;

        for (let i = 0; i < levelSize; i++) {
            let node = queue[i];

            if (node.left) {
                nextLevelNodes.push(node.left);
                nextLevelSum += node.left.val;
            }
            if (node.right) {
                nextLevelNodes.push(node.right);
                nextLevelSum += node.right.val;
            }
        }

        if (nextLevelNodes.length === 0) {
            break;
        }

        for (let i = 0; i < levelSize; i++) {
            let parent = queue.shift();

            let childrenSum = 0;
            if (parent.left) {
                childrenSum += parent.left.val;
            }
            if (parent.right) {
                childrenSum += parent.right.val;
            }

            if (parent.left) {
                parent.left.val = nextLevelSum - childrenSum;
            }
            if (parent.right) {
                parent.right.val = nextLevelSum - childrenSum;
            }
        }

        queue = nextLevelNodes;
    }

    return root;
};