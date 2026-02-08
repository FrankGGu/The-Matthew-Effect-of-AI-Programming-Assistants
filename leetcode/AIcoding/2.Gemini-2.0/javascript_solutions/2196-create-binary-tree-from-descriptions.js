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

        const parentNode = nodes.get(parentVal);
        const childNode = nodes.get(childVal);

        if (isLeft) {
            parentNode.left = childNode;
        } else {
            parentNode.right = childNode;
        }

        children.add(childVal);
    }

    let rootVal = null;
    for (const [parentVal] of descriptions) {
        if (!children.has(parentVal)) {
            rootVal = parentVal;
            break;
        }
    }

    return nodes.get(rootVal);
};