function createBinaryTree(description) {
    const nodes = new Map();
    const children = new Set();

    for (const [node, left, right] of description) {
        if (!nodes.has(node)) {
            nodes.set(node, { val: node, left: null, right: null });
        }
        if (!nodes.has(left)) {
            nodes.set(left, { val: left, left: null, right: null });
        }
        if (!nodes.has(right)) {
            nodes.set(right, { val: right, left: null, right: null });
        }

        if (left !== "null") {
            nodes.get(node).left = nodes.get(left);
            children.add(left);
        }
        if (right !== "null") {
            nodes.get(node).right = nodes.get(right);
            children.add(right);
        }
    }

    for (const [node] of description) {
        if (!children.has(node)) {
            return nodes.get(node);
        }
    }

    return null;
}