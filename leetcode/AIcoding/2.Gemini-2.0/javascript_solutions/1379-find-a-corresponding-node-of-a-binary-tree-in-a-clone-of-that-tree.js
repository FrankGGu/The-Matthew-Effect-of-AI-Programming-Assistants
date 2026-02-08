var getTargetCopy = function(original, cloned, target) {
    if (!original) return null;
    if (original === target) return cloned;

    let left = getTargetCopy(original.left, cloned.left, target);
    if (left) return left;

    return getTargetCopy(original.right, cloned.right, target);
};