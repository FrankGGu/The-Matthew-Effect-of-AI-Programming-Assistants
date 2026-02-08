var isSubtree = function(root, subRoot) {
    if (!subRoot) return true;
    if (!root) return false;

    if (isSameTree(root, subRoot)) return true;

    return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot);
};

var isSameTree = function(s, t) {
    if (!s && !t) return true;
    if (!s || !t) return false;

    return s.val === t.val && isSameTree(s.left, t.left) && isSameTree(s.right, t.right);
};