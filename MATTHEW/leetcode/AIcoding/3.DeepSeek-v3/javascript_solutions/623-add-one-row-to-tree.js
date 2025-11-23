var addOneRow = function(root, val, depth) {
    if (depth === 1) {
        const newRoot = new TreeNode(val);
        newRoot.left = root;
        return newRoot;
    }

    const queue = [root];
    let currentDepth = 1;

    while (queue.length > 0) {
        const levelSize = queue.length;

        if (currentDepth === depth - 1) {
            for (let i = 0; i < levelSize; i++) {
                const node = queue.shift();

                const left = node.left;
                const right = node.right;

                node.left = new TreeNode(val);
                node.left.left = left;

                node.right = new TreeNode(val);
                node.right.right = right;
            }
            break;
        } else {
            for (let i = 0; i < levelSize; i++) {
                const node = queue.shift();
                if (node.left) queue.push(node.left);
                if (node.right) queue.push(node.right);
            }
            currentDepth++;
        }
    }

    return root;
};