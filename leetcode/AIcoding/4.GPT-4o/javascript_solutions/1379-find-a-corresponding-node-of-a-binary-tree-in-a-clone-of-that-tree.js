var getTargetCopy = function(original, cloned, target) {
    if (!cloned) return null;
    if (original === target) return cloned;
    const left = getTargetCopy(original.left, cloned.left, target);
    if (left) return left;
    return getTargetCopy(original.right, cloned.right, target);
};