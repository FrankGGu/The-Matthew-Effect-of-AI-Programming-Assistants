var findTarget = function(root, k) {
    const set = new Set();

    function traverse(node) {
        if (!node) return false;

        if (set.has(k - node.val)) {
            return true;
        }

        set.add(node.val);

        return traverse(node.left) || traverse(node.right);
    }

    return traverse(root);
};