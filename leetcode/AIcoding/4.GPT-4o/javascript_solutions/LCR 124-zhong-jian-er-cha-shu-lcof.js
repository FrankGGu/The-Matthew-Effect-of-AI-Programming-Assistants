var createBinaryTree = function(descriptions) {
    const map = new Map();
    const nodes = new Set();

    for (const [parent, child, isLeft] of descriptions) {
        if (!map.has(parent)) map.set(parent, { left: null, right: null });
        if (!map.has(child)) map.set(child, { left: null, right: null });

        if (isLeft) {
            map.get(parent).left = child;
        } else {
            map.get(parent).right = child;
        }

        nodes.add(parent);
        nodes.add(child);
    }

    let root = null;
    for (const node of nodes) {
        if (!descriptions.some(([p, c]) => c === node)) {
            root = node;
            break;
        }
    }

    const buildTree = (node) => {
        if (!node) return null;
        const treeNode = new TreeNode(node);
        const children = map.get(node);
        treeNode.left = buildTree(children.left);
        treeNode.right = buildTree(children.right);
        return treeNode;
    };

    return buildTree(root);
};