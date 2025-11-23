var getDirections = function(root, startValue, destValue) {
    const pathStart = [];
    const pathDest = [];

    function getPathFromRoot(node, targetVal, currentPath) {
        if (!node) {
            return false;
        }

        if (node.val === targetVal) {
            return true;
        }

        currentPath.push('L');
        if (getPathFromRoot(node.left, targetVal, currentPath)) {
            return true;
        }
        currentPath.pop();

        currentPath.push('R');
        if (getPathFromRoot(node.right, targetVal, currentPath)) {
            return true;
        }
        currentPath.pop();

        return false;
    }

    getPathFromRoot(root, startValue, pathStart);
    getPathFromRoot(root, destValue, pathDest);

    let commonAncestorPathLength = 0;
    while (commonAncestorPathLength < pathStart.length &&
           commonAncestorPathLength < pathDest.length &&
           pathStart[commonAncestorPathLength] === pathDest[commonAncestorPathLength]) {
        commonAncestorPathLength++;
    }

    const upPath = 'U'.repeat(pathStart.length - commonAncestorPathLength);
    const downPath = pathDest.slice(commonAncestorPathLength).join('');

    return upPath + downPath;
};