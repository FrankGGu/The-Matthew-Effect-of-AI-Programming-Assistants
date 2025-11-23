var getTargetCopy = function(target, node) {
    if (!node) return null;
    if (node.val === target.val) return node;
    const left = getTargetCopy(target, node.left);
    if (left) return left;
    return getTargetCopy(target, node.right);
};