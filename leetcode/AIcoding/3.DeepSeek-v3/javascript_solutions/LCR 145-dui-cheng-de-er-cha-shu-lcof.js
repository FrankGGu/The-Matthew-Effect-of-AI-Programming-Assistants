var isSymmetric = function(root) {
    if (!root) return true;
    return compare(root.left, root.right);
};

function compare(left, right) {
    if (!left && !right) return true;
    if (!left || !right || left.val !== right.val) return false;
    return compare(left.left, right.right) && compare(left.right, right.left);
}