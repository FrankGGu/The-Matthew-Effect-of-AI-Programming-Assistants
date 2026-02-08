var getTargetCopy = function(original, cloned, target) {
    if (!original) {
        return null;
    }

    if (original === target) {
        return cloned;
    }

    let leftResult = getTargetCopy(original.left, cloned.left, target);
    if (leftResult) {
        return leftResult;
    }

    let rightResult = getTargetCopy(original.right, cloned.right, target);
    if (rightResult) {
        return rightResult;
    }

    return null;
};