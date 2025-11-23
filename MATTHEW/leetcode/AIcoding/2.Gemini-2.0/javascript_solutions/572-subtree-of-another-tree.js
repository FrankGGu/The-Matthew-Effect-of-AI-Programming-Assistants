var isSubtree = function(root, subRoot) {
    if (!root) return !subRoot;

    const isSameTree = (p, q) => {
        if (!p && !q) return true;
        if (!p || !q || p.val !== q.val) return false;
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }

    if (isSameTree(root, subRoot)) return true;
    return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot);
};