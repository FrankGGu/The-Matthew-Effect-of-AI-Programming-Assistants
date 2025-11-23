var getDirections = function(root, startValue, destValue) {
    let startPath = [], destPath = [];

    function findPath(node, target, path) {
        if (!node) return false;
        if (node.val === target) return true;

        if (node.left) {
            path.push('L');
            if (findPath(node.left, target, path)) return true;
            path.pop();
        }

        if (node.right) {
            path.push('R');
            if (findPath(node.right, target, path)) return true;
            path.pop();
        }

        return false;
    }

    findPath(root, startValue, startPath);
    findPath(root, destValue, destPath);

    let i = 0;
    while (i < startPath.length && i < destPath.length && startPath[i] === destPath[i]) {
        i++;
    }

    let result = '';
    for (let j = i; j < startPath.length; j++) {
        result += 'U';
    }

    for (let j = i; j < destPath.length; j++) {
        result += destPath[j];
    }

    return result;
};