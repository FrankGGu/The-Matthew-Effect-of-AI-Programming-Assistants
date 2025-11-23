var isSubStructure = function(A, B) {
    if (!A || !B) return false;
    return isSame(A, B) || isSubStructure(A.left, B) || isSubStructure(A.right, B);
};

function isSame(A, B) {
    if (!B) return true;
    if (!A || A.val !== B.val) return false;
    return isSame(A.left, B.left) && isSame(A.right, B.right);
}