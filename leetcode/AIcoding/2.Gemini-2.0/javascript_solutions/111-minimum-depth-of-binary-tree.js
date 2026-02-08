var minDepth = function(root) {
    if (!root) {
        return 0;
    }

    if (!root.left && !root.right) {
        return 1;
    }

    let min_depth = Infinity;

    if (root.left) {
        min_depth = Math.min(min_depth, minDepth(root.left));
    }

    if (root.right) {
        min_depth = Math.min(min_depth, minDepth(root.right));
    }

    return min_depth + 1;
};