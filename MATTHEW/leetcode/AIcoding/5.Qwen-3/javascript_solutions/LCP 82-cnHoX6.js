function isSubtree(s, t) {
    if (!s || !t) return false;
    if (isSameTree(s, t)) return true;
    return isSubtree(s.left, t) || isSubtree(s.right, t);
}

function isSameTree(s, t) {
    if (!s && !t) return true;
    if (!s || !t) return false;
    return s.val === t.val && isSameTree(s.left, t.left) && isSameTree(s.right, t.right);
}