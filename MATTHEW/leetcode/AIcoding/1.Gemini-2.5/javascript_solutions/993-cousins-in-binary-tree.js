var isCousins = function(root, x, y) {
    if (!root) {
        return false;
    }

    let xInfo = { parent: null, depth: -1 };
    let yInfo = { parent: null, depth: -1 };

    let queue = [[root, null, 0]]; // [node, parentNode, depth]

    while (queue.length > 0) {
        let [currentNode, currentParent, currentDepth] = queue.shift();

        if (currentNode.val === x) {
            xInfo.parent = currentParent;
            xInfo.depth = currentDepth;
        } else if (currentNode.val === y) {
            yInfo.parent = currentParent;
            yInfo.depth = currentDepth;
        }

        if (xInfo.depth !== -1 && yInfo.depth !== -1) {
            break; 
        }

        if (currentNode.left) {
            queue.push([currentNode.left, currentNode, currentDepth + 1]);
        }
        if (currentNode.right) {
            queue.push([currentNode.right, currentNode, currentDepth + 1]);
        }
    }

    return xInfo.depth === yInfo.depth && xInfo.parent !== yInfo.parent;
};