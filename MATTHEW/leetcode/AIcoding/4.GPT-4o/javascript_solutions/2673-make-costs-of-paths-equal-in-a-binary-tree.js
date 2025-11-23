class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var minCost = function(root, start, goal) {
    const distances = {};
    const queue = [[root, 0]];

    while (queue.length > 0) {
        const [node, cost] = queue.shift();
        if (!node) continue;
        distances[node.val] = cost;
        queue.push([node.left, cost + 1]);
        queue.push([node.right, cost + 1]);
    }

    return distances[goal] !== undefined ? distances[goal] : -1;
};