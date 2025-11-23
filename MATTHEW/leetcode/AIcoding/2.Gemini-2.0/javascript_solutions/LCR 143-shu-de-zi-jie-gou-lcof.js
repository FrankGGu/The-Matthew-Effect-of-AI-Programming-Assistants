var isSubStructure = function(A, B) {
    if (!A || !B) return false;

    function recur(a, b) {
        if (!b) return true;
        if (!a || a.val !== b.val) return false;
        return recur(a.left, b.left) && recur(a.right, b.right);
    }

    return recur(A, B) || isSubStructure(A.left, B) || isSubStructure(A.right, B);
};