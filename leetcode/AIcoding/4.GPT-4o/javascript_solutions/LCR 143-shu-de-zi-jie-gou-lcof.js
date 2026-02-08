function isSubStructure(A, B) {
    if (!A || !B) return false;

    function isSameTree(a, b) {
        if (!b) return true;
        if (!a || a.val !== b.val) return false;
        return isSameTree(a.left, b.left) && isSameTree(a.right, b.right);
    }

    return isSameTree(A, B) || isSubStructure(A.left, B) || isSubStructure(A.right, B);
}