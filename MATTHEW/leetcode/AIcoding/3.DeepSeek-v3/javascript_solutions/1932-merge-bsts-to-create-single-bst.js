var canMerge = function(trees) {
    const leaves = new Set();
    const treeMap = new Map();

    for (const tree of trees) {
        treeMap.set(tree.val, tree);
        if (tree.left) leaves.add(tree.left.val);
        if (tree.right) leaves.add(tree.right.val);
    }

    let root = null;
    for (const tree of trees) {
        if (!leaves.has(tree.val)) {
            root = tree;
            break;
        }
    }

    if (!root) return null;

    const seen = new Set();
    let isValid = true;
    let prev = null;

    const inorder = (node) => {
        if (!node || !isValid) return;
        inorder(node.left);
        if (prev !== null && node.val <= prev) {
            isValid = false;
            return;
        }
        prev = node.val;
        inorder(node.right);
    };

    const build = (node) => {
        if (!node) return;
        if (!node.left && !node.right && treeMap.has(node.val)) {
            const subTree = treeMap.get(node.val);
            node.left = subTree.left;
            node.right = subTree.right;
            treeMap.delete(node.val);
        }
        build(node.left);
        build(node.right);
    };

    build(root);
    if (treeMap.size !== 1) return null;

    inorder(root);
    if (!isValid) return null;

    return root;
};