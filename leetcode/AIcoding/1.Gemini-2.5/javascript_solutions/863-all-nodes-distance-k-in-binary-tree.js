var distanceK = function(root, target, k) {
    const parentMap = new Map();

    function mapParents(node, parent) {
        if (!node) {
            return;
        }
        parentMap.set(node, parent);
        mapParents(node.left, node);
        mapParents(node.right, node);
    }

    mapParents(root, null);

    const queue = [[target, 0]];
    const visited = new Set();
    visited.add(target);
    const result = [];

    let head = 0;

    while (head < queue.length) {
        const [currentNode, currentDistance] = queue[head++];

        if (currentDistance === k) {
            result.push(currentNode.val);
            continue; 
        }

        if (currentDistance > k) {
            continue;
        }

        const neighbors = [
            currentNode.left,
            currentNode.right,
            parentMap.get(currentNode)
        ];

        for (const neighbor of neighbors) {
            if (neighbor && !visited.has(neighbor)) {
                visited.add(neighbor);
                queue.push([neighbor, currentDistance + 1]);
            }
        }
    }

    return result;
};