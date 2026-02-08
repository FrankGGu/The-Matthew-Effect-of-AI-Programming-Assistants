class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var largestValues = function(root) {
    if (!root) return [];
    const result = [];
    const queue = [root];

    while (queue.length > 0) {
        let max = -Infinity;
        const size = queue.length;

        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            max = Math.max(max, node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        result.push(max);
    }

    return result;
};