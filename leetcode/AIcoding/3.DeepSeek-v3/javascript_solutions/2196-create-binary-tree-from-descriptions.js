var createBinaryTree = function(descriptions) {
    const nodes = new Map();
    const children = new Set();

    for (const [parent, child, isLeft] of descriptions) {
        const parentNode = nodes.get(parent) || new TreeNode(parent);
        const childNode = nodes.get(child) || new TreeNode(child);

        if (isLeft) {
            parentNode.left = childNode;
        } else {
            parentNode.right = childNode;
        }

        nodes.set(parent, parentNode);
        nodes.set(child, childNode);
        children.add(child);
    }

    for (const [parent, _, __] of descriptions) {
        if (!children.has(parent)) {
            return nodes.get(parent);
        }
    }

    return null;
};