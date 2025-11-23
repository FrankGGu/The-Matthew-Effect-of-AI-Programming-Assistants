var getDirections = function(root, startValue, destValue) {
    let startPath = "";
    let destPath = "";

    function findPath(node, target, path) {
        if (!node) return false;
        if (node.val === target) {
            return true;
        }

        if (findPath(node.left, target, path + "L")) {
            path = path + "L";
            if (node.val === startValue) startPath = path + "L";
            if (node.val === destValue) destPath = path + "L";
            return true;
        }

        if (findPath(node.right, target, path + "R")) {
            path = path + "R";
            if (node.val === startValue) startPath = path + "R";
            if (node.val === destValue) destPath = path + "R";
            return true;
        }

        return false;
    }

    findPath(root, startValue, "");
    findPath(root, destValue, "");

    let i = 0;
    while (i < startPath.length && i < destPath.length && startPath[i] === destPath[i]) {
        i++;
    }

    let upMoves = "U".repeat(startPath.length - i);
    let downMoves = destPath.substring(i);

    return upMoves + downMoves;
};