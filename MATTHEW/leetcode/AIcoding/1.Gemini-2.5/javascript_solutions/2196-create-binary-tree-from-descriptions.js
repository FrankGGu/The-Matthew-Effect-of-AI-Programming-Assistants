var createBinaryTree = function(descriptions) {
    const nodes = new Map();
    const children = new Set();

    for (const [parentVal, childVal, isLeft] of descriptions) {
        if (!nodes.has(parentVal)) {
            nodes.set(parentVal, new TreeNode(parentVal));
        }
        if (!nodes.has(childVal)) {
            nodes.set(childVal, new TreeNode(childVal));
        }

        children.add(childVal);

        const parentNode = nodes.get(parentVal);
        const childNode = nodes.get(childVal);

        if (isLeft === 1) {
            parentNode.left = childNode;
        } else {
            parentNode.right = childNode;
        }
    }

    for (const nodeVal of nodes.keys()) {
        if (!children.has(nodeVal)) {
            return nodes.get(nodeVal);
        }
    }

    return null;
};