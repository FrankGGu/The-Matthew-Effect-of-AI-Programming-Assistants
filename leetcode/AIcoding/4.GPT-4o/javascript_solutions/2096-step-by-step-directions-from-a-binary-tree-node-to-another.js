var getDirections = function(root, startValue, destValue) {
    const parent = new Map();
    const findParents = (node, par) => {
        if (!node) return;
        parent.set(node.val, par);
        findParents(node.left, node.val);
        findParents(node.right, node.val);
    };
    findParents(root, null);

    const lca = (node) => {
        if (!node || node.val === startValue || node.val === destValue) return node;
        const left = lca(node.left);
        const right = lca(node.right);
        if (left && right) return node;
        return left || right;
    };

    const lcaNode = lca(root);
    const pathToStart = [];
    const pathToDest = [];

    const findPath = (node, value, path) => {
        if (!node) return false;
        path.push(node.val);
        if (node.val === value) return true;
        if (findPath(node.left, value, path) || findPath(node.right, value, path)) return true;
        path.pop();
        return false;
    };

    findPath(lcaNode, startValue, pathToStart);
    findPath(lcaNode, destValue, pathToDest);

    const upMoves = pathToStart.length - 1;
    const downMoves = pathToDest.length;

    let directions = 'U'.repeat(upMoves);
    directions += pathToDest.slice(1).join('').replace(/(\d+)/g, 'L$1').replace(/(\d+)/g, 'R$1');

    return directions;
};