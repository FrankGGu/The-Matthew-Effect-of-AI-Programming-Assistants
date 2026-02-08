var checkTree = function(root) {
    if (!root) return true;
    if (!root.left && !root.right) return true;
    let sum = 0;
    if (root.left) sum += root.left.val;
    if (root.right) sum += root.right.val;
    return root.val === sum;
};