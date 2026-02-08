var canMerge = function(trees) {
    const map = new Map();
    const roots = new Set();

    for (const tree of trees) {
        map.set(tree.val, tree);
        roots.add(tree.val);
    }

    for (const tree of trees) {
        if (tree.left) {
            if (roots.has(tree.left.val)) {
                roots.delete(tree.left.val);
            }
        }
        if (tree.right) {
            if (roots.has(tree.right.val)) {
                roots.delete(tree.right.val);
            }
        }
    }

    if (roots.size !== 1) {
        return null;
    }

    let rootVal = roots.values().next().value;
    let root = map.get(rootVal);

    function isValidBST(node, min, max) {
        if (!node) {
            return true;
        }

        if ((min !== null && node.val <= min) || (max !== null && node.val >= max)) {
            return false;
        }

        return isValidBST(node.left, min, node.val) && isValidBST(node.right, node.val, max);
    }

    function merge(node) {
        if (!node) {
            return;
        }

        if (node.left && map.has(node.left.val)) {
            node.left = map.get(node.left.val);
            map.delete(node.left.val);
        }

        if (node.right && map.has(node.right.val)) {
            node.right = map.get(node.right.val);
            map.delete(node.right.val);
        }

        merge(node.left);
        merge(node.right);
    }

    merge(root);

    if (map.size > 0) return null;

    if (!isValidBST(root, null, null)) return null;

    return root;
};