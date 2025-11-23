var addOneRow = function(root, val, depth) {
    if (depth === 1) {
        const newRoot = new TreeNode(val);
        newRoot.left = root;
        return newRoot;
    }

    let queue = [root];
    let currentDepth = 1;

    while (queue.length > 0) {
        let levelSize = queue.length;

        if (currentDepth === depth - 1) {
            for (let i = 0; i < levelSize; i++) {
                let node = queue[i];

                const newLeftNode = new TreeNode(val);
                newLeftNode.left = node.left;
                node.left = newLeftNode;

                const newRightNode = new TreeNode(val);
                newRightNode.right = node.right;
                node.right = newRightNode;
            }
            return root;
        }

        let nextQueue = [];
        for (let i = 0; i < levelSize; i++) {
            let node = queue[i];
            if (node.left) {
                nextQueue.push(node.left);
            }
            if (node.right) {
                nextQueue.push(node.right);
            }
        }
        queue = nextQueue;
        currentDepth++;
    }

    return root;
};