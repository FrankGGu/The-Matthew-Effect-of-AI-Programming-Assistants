var isCousins = function(root, x, y) {
    const queue = [{ node: root, parent: null, depth: 0 }];
    let xInfo = null, yInfo = null;

    while (queue.length) {
        const { node, parent, depth } = queue.shift();
        if (node) {
            if (node.val === x) xInfo = { parent, depth };
            if (node.val === y) yInfo = { parent, depth };
            queue.push({ node: node.left, parent: node, depth: depth + 1 });
            queue.push({ node: node.right, parent: node, depth: depth + 1 });
        }
        if (xInfo && yInfo) break;
    }

    return xInfo && yInfo && xInfo.depth === yInfo.depth && xInfo.parent !== yInfo.parent;
};