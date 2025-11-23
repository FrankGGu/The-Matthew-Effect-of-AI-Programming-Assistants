var maxDepth = function(root) {
    if (!root) {
        return 0;
    }

    if (!root.children || root.children.length === 0) {
        return 1;
    }

    let maxChildDepth = 0;
    for (let i = 0; i < root.children.length; i++) {
        maxChildDepth = Math.max(maxChildDepth, maxDepth(root.children[i]));
    }

    return 1 + maxChildDepth;
};