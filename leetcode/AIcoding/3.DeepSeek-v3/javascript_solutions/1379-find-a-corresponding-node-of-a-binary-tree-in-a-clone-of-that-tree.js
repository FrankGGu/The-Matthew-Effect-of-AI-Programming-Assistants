var getTargetCopy = function(original, cloned, target) {
    if (!original) return null;
    if (original === target) return cloned;

    const left = getTargetCopy(original.left, cloned.left, target);
    if (left) return left;

    const right = getTargetCopy(original.right, cloned.right, target);
    return right;
};